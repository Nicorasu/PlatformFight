/// @description Insert description here
// You can write your code in this editor
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_up = keyboard_check_pressed(vk_up);
key_down = keyboard_check_pressed(vk_down);

var move = key_right - key_left
//movement
if(!diveKick) {
	hsp = move * walkSpd;
}
vsp += grv;


if(place_meeting(x,y+1,obj_Wall) && key_up) {
	vsp = -10;

}
if(!place_meeting(x,y+1,obj_Wall) && key_down) {
	vsp = 7;
	hsp = hsp + 5 * sign(hsp);
	diveKick = true;
}
//horizontal Collision
if(place_meeting(x+hsp,y,obj_Wall)) {
	while(!place_meeting(x+sign(hsp),y,obj_Wall)) {
	
		x += sign(hsp);
	}
	hsp = 0;
}


x += hsp;

//vertical Collision


if(place_meeting(x,y+vsp,obj_Wall)) {
	while(!place_meeting(x,y+sign(vsp),obj_Wall)) {
	
		y += sign(vsp);
	}
	vsp = 0;
}


y += vsp;

//animation

if(diveKick&& !place_meeting(x,y+1,obj_Wall)) {
	image_speed = 0;
	sprite_index = spr_PlayerDK;
	instance_create_layer(x,y+32,"Cracks",obj_Fire)
	
} else if(!place_meeting(x,y+1,obj_Wall)) {
	sprite_index = spr_PlayerA;
	image_speed = 0;
	if(sign(vsp) > 0) {
		image_index =1;
	} else {
	image_index = 0;
	}
} else if(diveKick) {
	diveKick = false;
	instance_create_layer(x-32,y+32,"Cracks",obj_Crack);
}else{
	image_speed = 1;
	
	if(hsp == 0) {
		sprite_index = spr_Player;
	}else {
		sprite_index = spr_PlayerR;
	}
}

if(hsp !=0) {
	image_xscale = abs(image_xscale)*sign(hsp);
}