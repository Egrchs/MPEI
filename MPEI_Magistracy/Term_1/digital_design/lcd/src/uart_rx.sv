module uart_rx 
#(
	parameter 	BIT_RATE     = 115200,
				CLK_HZ       = 27_000_000,
				PAYLOAD_BITS = 8
)
(
	input  logic                        CLK_I,      // Системный тактовый сигнал
	input  logic                        RST_N_I,    // Асинхронный глобальный сброс (активный уровень 0)
	input  logic                        RX_D_I,     // Пин принимаемых UART значений
	input  logic                        RX_EN_I,    // Разрешение приёма данных
	output logic                        RX_BREAK_O, // Было ли получено сообщение прерывании приёма?
	output logic                        RX_VLD_O, 	// Получены и доступны достоверные данные
	output logic [PAYLOAD_BITS - 1 : 0] RX_D_O   	// Принятые данные
	);
	
	// --------------------------------------------------------------------------- 
	// Внешние параметры
	// --------------------------------------------------------------------------- 
	
	// Скорость передачи данных UART
	// parameter   BIT_RATE = 9600;
	localparam  BIT_P   = 1_000_000_000 * 1 / BIT_RATE; // nanoseconds
	
	// Частота тактового сигнала в Гц
	// parameter CLK_I_HZ = 27_000_000;
	localparam  CLK_P   = 1_000_000_000 * 1 / CLK_HZ; // period in nanoseconds
	
	// Количество информационны бит-данных, принимаетмых UART
	// parameter PAYLOAD_BITS    = 8;
	
	// Количество стоп-бит, определяющих завершение принимаемой посылки
	parameter STOP_BITS = 1;
	
	// -------------------------------------------------------------------------- 
	// Внутренние параметры
	// ---------------------------------------------------------------------------
	
	// Количество циклов тактового сигнала на один принимаемый бит
	localparam CYCLES_PER_BIT = BIT_P / CLK_P;
	
	// Размер регистров, хранящих количество выборок и длительность битов
	localparam COUNT_REG_LEN  = 1 + $clog2(CYCLES_PER_BIT);
	
	// -------------------------------------------------------------------------- 
	// Внутренние регистры
	// ---------------------------------------------------------------------------
	
		// Регистр, через который осуществляется синхронизация принимаемых извне значений (два триггера)
	logic [1:0] rxd_reg;
	
	// Регистр, хранящий принятые последовательные данные
	logic [PAYLOAD_BITS-1:0] recieved_data;
	
	// Счётчик количества циклов тактового сигнала в пакетном бите
	logic [COUNT_REG_LEN-1:0] cycle_counter;
	
	// Счётчик количества принятый в пакете бит
	logic [$clog2(COUNT_REG_LEN)-1:0] bit_counter;
	
	// Захват и хранение поступающих данных, в момент чтения середины фрейма входного бита
	logic bit_sample;
	
	// Определение текущего и следующего состояний внутреннего конечного автомата
	typedef enum {
		FSM_IDLE, 
		FSM_START, 
		FSM_RECV, 
		FSM_STOP 
	} state_t;

	state_t State, NextState;
	
	// --------------------------------------------------------------------------- 
	// Назначение выходных данных
	// ---------------------------------------------------------------------------
	
	assign RX_BREAK_O = (RX_VLD_O && ~|recieved_data);
	assign RX_VLD_O = ((State == FSM_STOP) && (NextState == FSM_IDLE));
	
	always_ff @(posedge CLK_I) begin
		if (!RST_N_I) begin
			RX_D_O  <= {PAYLOAD_BITS{1'b0}};
		end 
		else if (State == FSM_STOP) begin
			RX_D_O  <= recieved_data;
		end
	end
	
	// --------------------------------------------------------------------------- 
	// Выбор следющего состояния конечного автомата
	// ---------------------------------------------------------------------------
	
	logic next_bit;
	logic payload_done;
	
	assign next_bit = ((cycle_counter == CYCLES_PER_BIT) ||
					   (State         == FSM_STOP      ) && 
					   (cycle_counter == CYCLES_PER_BIT / 2 ));

	assign payload_done = (bit_counter == PAYLOAD_BITS);
	
	// Логика выбора следующего состояния
	always_comb begin : p_NextState
		case (State)
			FSM_IDLE  : if(rxd_reg) 
							NextState = FSM_IDLE;
						else              
							NextState = FSM_START;
			FSM_START : if(next_bit) 
							NextState = FSM_RECV;
						else              
							NextState = FSM_START;
			FSM_RECV  : if(payload_done) 
							NextState = FSM_STOP;
						else              
							NextState = FSM_RECV;
			FSM_STOP  : if(next_bit     ) 
							NextState = FSM_IDLE;
						else              
							NextState = FSM_STOP  ;
			default   :	
						NextState = FSM_IDLE;
		endcase
	end
	
	// --------------------------------------------------------------------------- 
	// Настройка и сброс внутренних регистров
	// ---------------------------------------------------------------------------
	
	// Работа сдвигового регистра, принимающего поступающие данные
	always_ff @(posedge CLK_I) begin : p_recieved_data
		if (!RST_N_I) begin
			recieved_data <= {PAYLOAD_BITS{1'b0}};
		end 
		else if (State == FSM_IDLE             ) begin
			recieved_data <= {PAYLOAD_BITS{1'b0}};
		end 
		else if (State == FSM_RECV && next_bit ) begin
			recieved_data[PAYLOAD_BITS-1] <= bit_sample;
			for (int i = PAYLOAD_BITS-2; i >= 0; i--) begin
				recieved_data[i] <= recieved_data[i+1];
			end
		end
	end
	
	// Увеличение значения счётчика поступивших бит данных
	always_ff @(posedge CLK_I) begin : p_bit_counter
		if (!RST_N_I) begin
			bit_counter <= {COUNT_REG_LEN{1'b0}};
		end 
		else if (State != FSM_RECV) begin
			bit_counter <= {COUNT_REG_LEN{1'b0}};
		end 
		else if (State == FSM_RECV && next_bit) begin
			bit_counter <= bit_counter + 1'b1;
		end
	end
	
	// Захват принятого бита, когда находимся по центру фрейма данного бита
	always_ff @(posedge CLK_I) begin : p_bit_sample
		if (!RST_N_I) begin
			bit_sample <= 1'b0;
		end 
		else if (cycle_counter == CYCLES_PER_BIT/2) begin
			bit_sample <= rxd_reg;
		end
	end
	
	// Работа счётчика циклов тактового сигнала в течение поступившего одного бита данных
	always_ff @(posedge CLK_I) begin : p_cycle_counter
		if (!RST_N_I) begin
			cycle_counter <= {COUNT_REG_LEN{1'b0}};
		end 
		else if (next_bit) begin
			cycle_counter <= {COUNT_REG_LEN{1'b0}};
		end 
		else if (State == FSM_START || 
					 State == FSM_RECV  || 
					 State == FSM_STOP   ) begin
			cycle_counter <= cycle_counter + 1'b1;
		end
	end
	
	// Условие переключения в следующее состояние
	always_ff @(posedge CLK_I) begin : p_State
		if (!RST_N_I) begin
			State <= FSM_IDLE;
		end 
		else begin
			State <= NextState;
		end
	end
	
	// Синхронизация данных, принятых извне через два регистра
	always_ff @(posedge CLK_I) begin : p_rxd_reg
		if (!RST_N_I) begin
			rxd_reg <= 2'b11;
		end 
		else if (RX_EN_I) begin
			rxd_reg <= {rxd_reg[0], RX_D_I};
		end
	end

endmodule