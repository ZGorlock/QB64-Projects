'load gui
DIM SHARED GUI_box AS LONG
DIM SHARED GUI_box_trans AS LONG
DIM SHARED GUI_box_special AS LONG
DIM SHARED GUI_box_special_trans AS LONG
DIM SHARED GUI_box_special_large AS LONG
DIM SHARED GUI_box_special_large_trans AS LONG
GUI_box = _LOADIMAGE("resource\image\gui\box.png")
GUI_box_trans = _LOADIMAGE("resource\image\gui\box_trans.png")
GUI_box_special = _LOADIMAGE("resource\image\gui\box_special.png")
GUI_box_special_trans = _LOADIMAGE("resource\image\gui\box_special_trans.png")
GUI_box_special_large = _LOADIMAGE("resource\image\gui\box_special_large.png")
GUI_box_special_large_trans = _LOADIMAGE("resource\image\gui\box_special_large_trans.png")
LOADFRAME FRAME_GOLD, Frameloc$