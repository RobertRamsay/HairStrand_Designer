
draw_text(x,y," COPY  PASTE ")

if mouse_x>x-20 and mouse_x<x+10 and mouse_y>y-20 and mouse_y<y
//if point_in_rectangle(mouse_x,mouse_y,x-10,y-10,x+10,y+10)
	{
	draw_text(x,y,"[COPY] PASTE ")
	if mouse_check_button (mb_left)
	and obj_surfaceDweller.setSelectedID!=-1
		{
		draw_text(x,y-20,"Settings copied from "+string(obj_surfaceDweller.setSelectedID+1));
		// store settings for current set
		}
	}

if mouse_x>x+20 and mouse_x<x+30 and mouse_y>y-20 and mouse_y<y
//if point_in_rectangle(mouse_x,mouse_y,x-10,y-10,x+10,y+10)
	{
	draw_text(x,y," COPY [PASTE] ")
	if mouse_check_button (mb_left)
	and obj_surfaceDweller.setSelectedID!=-1
		{
		draw_text(x,y-20,"Settings pasted to "+string(obj_surfaceDweller.setSelectedID+1));
		// store settings for current set
		}
	}

