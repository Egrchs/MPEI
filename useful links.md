1.1 [tcl randomization method](https://wiki.tcl-lang.org/page/rand)

1.2 [SDC manual](https://iccircle.com/static/upload/img20240131000211.pdf)

```tcl
if { [info exists fab] } {
    if { ${fab} == "tsmc" } {
        puts "fab tsmc\n"
        puts "$$$$$$$$\\  $$$$$$\\  $$\\      $$\\  $$$$$$\\  "
        puts "\\__$$  __|$$  __$$\\ $$$\\    $$$ |$$  __$$\\ "
        puts "   $$ |   $$ /  \\__|$$$$\\  $$$$ |$$ /  \\__|"
        puts "   $$ |   \\$$$$$$\\  $$\\$$\\$$ $$ |$$ |      "
        puts "   $$ |    \\____$$\\ $$ \\$$$  $$ |$$ |      "
        puts "   $$ |   $$\\   $$ |$$ |\\$  /$$ |$$ |  $$\\ "
        puts "   $$ |   \\$$$$$$  |$$ | \\_/ $$ |\\$$$$$$  |"
        puts "   \\__|    \\______/ \\__|     \\__| \\______/ "
    } elseif { ${fab} == "smic" } {
        puts "fab smic\n"
        puts " $$$$$$\\  $$\\      $$\\ $$$$$$\\  $$$$$$\\  "  
        puts "$$  __$$\\ $$$\\    $$$ |\\_$$  _|$$  __$$\\ "  
        puts "$$ /  \\__|$$$$\\  $$$$ |  $$ |  $$ /  \\__|"  
        puts "\\$$$$$$\\  $$\\$$\\$$ $$ |  $$ |  $$ |      "  
        puts " \\____$$\\ $$ \\$$$  $$ |  $$ |  $$ |      "  
        puts "$$\\   $$ |$$ |\\$  /$$ |  $$ |  $$ |  $$\\ "  
        puts "\\$$$$$$  |$$ | \\_/ $$ |$$$$$$\\ \\$$$$$$  |"  
        puts " \\______/ \\__|     \\__|\\______| \\______/ "
    } else {
        error "ERROR: wrong fab!"
    }
} else {
    error "ERROR: fab not found!"
}
puts "\n"

```
