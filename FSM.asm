FSM
    db_count = 0
    long_count = 0
    state = 0
    if result == 1&&(state == 0||state == 4||state == 5||state == 6)
    state equ 1
    else if result == 0&&state == 1
    state equ 2
    else if result == 0&&state == 2&&long_count<L
    movlw 1
    addwf long_count,1
    else if result == 0&&state == 2&&long_count>L
    state equ 6					;long_click
    else if result == 1&&state == 2&&long_count<L
    state equ 3
    else if result == 1&&state == 3&&db_count<D
    movlw 1
    addwf db_count,1
    else if result == 0&&state == 3&&db_count<D
    state equ 5					;double click
    else if result == 1&&state == 3&&db_count>D
    state equ 4                                 ;single click