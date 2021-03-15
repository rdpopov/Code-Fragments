" Description:
"
" This is a little tiny bit smart function to resize splits in vim,
" with the quirk of not meddling with the cmdheigth. Ye i know its kinda
" niche, but so is vim/nvim.
"
" Q:So why does this exist when there are plugins that possibly do that?
" A: Well the plugins I tried did more than that, i wanted just resize
" functionality. They are good plugins mind you, but the ones i tried 
" behaved more or less just like the resize command, witch frankly i could
" write myself and not use a plugin, so I did.
function ResizeWith(cmd)
    let l:vim_size_horz = &columns
    let l:vim_size_vert = &lines
    let l:spl_dims = [winheight(0),winwidth(0)]
    let l:win_coords_u = win_screenpos(0)
    let l:layout = winlayout()
    let l:winid = win_getid(0)
    let l:cmd_heigth_size = &cmdheight + 1
    let l:exists_tabline = 0
    if tabpagenr('$')>1 && &showtabline == 1
        let l:cmd_heigth_size = l:cmd_heigth_size + 1
        let l:exists_tabline = 1
    endif
    if a:cmd == 'k'
        " is full vertical window
        if l:spl_dims[0] + 2 + l:exists_tabline == l:vim_size_vert
            echo ""
        else
            if l:win_coords_u[0] == (1 + l:exists_tabline)
                :resize -1
                redraw
            elseif l:spl_dims[0] + l:win_coords_u[0] + 1 == l:vim_size_vert
                :resize +1
                redraw
            endif 
        endif 
    elseif a:cmd == 'j'
        " is full vertical window
        if l:spl_dims[0] + 2 + l:exists_tabline == l:vim_size_vert
            echo ""
        else
            " is upper window
            if l:win_coords_u[0] == (1 + l:exists_tabline)
                :resize +1
                redraw
            " is lower window
            elseif l:spl_dims[0] + l:win_coords_u[0] + 1 == l:vim_size_vert
                :resize -1
                redraw
            endif 
        endif
    elseif a:cmd == 'h'
        if l:win_coords_u[1] >= l:vim_size_vert
            :vertical resize +1
            redraw
        else
            :vertical resize -1
            redraw
        endif
    elseif a:cmd == 'l'
        if l:win_coords_u[1] >= l:vim_size_vert
            :vertical resize -1
            redraw
        else
            :vertical resize +1
            redraw
        endif
    endif
endfunction
