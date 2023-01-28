; 探索派遣相关坐标
; 蒙德 凯瑟琳
2560x1440_ksl_x:=1800
2560x1440_ksl_y:=880

1920x1080_ksl_x:=1350
1920x1080_ksl_y:=660

use_ksl_x:=0
use_ksl_y:=0
; 右下角按钮（领取/选择角色）
2560x1440_rbb_x:=2300
2560x1440_rbb_y:=1360

1920x1080_rbb_x:=1725
1920x1080_rbb_y:=1020

use_rbb_x:=0
use_rbb_y:=0
; 20h
2560x1440_20h_x:=2400
2560x1440_20h_y:=900

1920x1080_20h_x:=1800
1920x1080_20h_y:=675

use_20h_x:=0
use_20h_y:=0
; 蒙德
2560x1440_md_x:=180
2560x1440_md_y:=220

1920x1080_md_x:=135
1920x1080_md_y:=165

use_md_x:=0
use_md_y:=0
; 璃月
2560x1440_ly_x:=180
2560x1440_ly_y:=310

1920x1080_ly_x:=135
1920x1080_ly_y:=232

use_ly_x:=0
use_ly_y:=0
; 稻妻
2560x1440_dq_x:=180
2560x1440_dq_y:=410

1920x1080_dq_x:=135
1920x1080_dq_y:=307

use_dq_x:=0
use_dq_y:=0
; 1st character
2560x1440_1st_x:= 160
2560x1440_1st_y:= 220

1920x1080_1st_x:= 120
1920x1080_1st_y:= 165

use_1st_x:=0
use_1st_y:=0
; 2nd character
2560x1440_2nd_x:= 160
2560x1440_2nd_y:= 390

1920x1080_2nd_x:= 120
1920x1080_2nd_y:= 292

use_2nd_x:=0
use_2nd_y:=0
; dysl
2560x1440_dysl_x:= 1400
2560x1440_dysl_y:= 450

1920x1080_dysl_x:= 1050
1920x1080_dysl_y:= 337

use_dysl_x:=0
use_dysl_y:=0
; ddpw
2560x1440_ddpw_x:= 1600
2560x1440_ddpw_y:= 900

1920x1080_ddpw_x:= 1200
1920x1080_ddpw_y:= 675

use_ddpw_x:=0
use_ddpw_y:=0
; ygt
2560x1440_ygt_x:= 1300
2560x1440_ygt_y:= 600

1920x1080_ygt_x:= 975
1920x1080_ygt_y:= 450

use_ygt_x:=0
use_ygt_y:=0
; gly
2560x1440_gly_x:= 1075
2560x1440_gly_y:= 745

1920x1080_gly_x:= 806
1920x1080_gly_y:= 558

use_gly_x:=0
use_gly_y:=0
; tbs
2560x1440_tbs_x:= 1100
2560x1440_tbs_y:= 1100

1920x1080_tbs_x:= 825
1920x1080_tbs_y:= 825

use_tbs_x:=0
use_tbs_y:=0

Use2560x1440(){
    global use_ksl_x, 2560x1440_ksl_x
    use_ksl_x = %2560x1440_ksl_x%
    global use_ksl_y, 2560x1440_ksl_y
    use_ksl_y=%2560x1440_ksl_y%
    global use_rbb_x, 2560x1440_rbb_x
    use_rbb_x=%2560x1440_rbb_x%
    global use_rbb_y, 2560x1440_rbb_y
    use_rbb_y=%2560x1440_rbb_y%
    global use_20h_x, 2560x1440_20h_x
    use_20h_x=%2560x1440_20h_x%
    global use_20h_y, 2560x1440_20h_y
    use_20h_y=%2560x1440_20h_y%
    global use_md_x, 2560x1440_md_x
    use_md_x=%2560x1440_md_x%
    global use_md_y, 2560x1440_md_y
    use_md_y=%2560x1440_md_y%
    global use_ly_x, 2560x1440_ly_x
    use_ly_x=%2560x1440_ly_x%
    global use_ly_y, 2560x1440_ly_y
    use_ly_y=%2560x1440_ly_y%
    global use_dq_x, 2560x1440_dq_x
    use_dq_x=%2560x1440_dq_x%
    global use_dq_y, 2560x1440_dq_y
    use_dq_y=%2560x1440_dq_y%
    global use_1st_x, 2560x1440_1st_x
    use_1st_x=%2560x1440_1st_x%
    global use_1st_y, 2560x1440_1st_y
    use_1st_y=%2560x1440_1st_y%
    global use_2nd_x, 2560x1440_2nd_x
    use_2nd_x=%2560x1440_2nd_x%
    global use_2nd_y, 2560x1440_2nd_y
    use_2nd_y=%2560x1440_2nd_y%
    global use_dysl_x, 2560x1440_dysl_x
    use_dysl_x=%2560x1440_dysl_x%
    global use_dysl_y, 2560x1440_dysl_y
    use_dysl_y=%2560x1440_dysl_y%
    global use_ddpw_x, 2560x1440_ddpw_x
    use_ddpw_x=%2560x1440_ddpw_x%
    global use_ddpw_y, 2560x1440_ddpw_y
    use_ddpw_y=%2560x1440_ddpw_y%
    global use_ygt_x, 2560x1440_ygt_x
    use_ygt_x=%2560x1440_ygt_x%
    global use_ygt_y, 2560x1440_ygt_y
    use_ygt_y=%2560x1440_ygt_y%
    global use_gly_x, 2560x1440_gly_x
    use_gly_x=%2560x1440_gly_x%
    global use_gly_y, 2560x1440_gly_y
    use_gly_y=%2560x1440_gly_y%
    global use_tbs_x, 2560x1440_tbs_x
    use_tbs_x=%2560x1440_tbs_x%
    global use_tbs_y, 2560x1440_tbs_y
    use_tbs_y=%2560x1440_tbs_y%
}

Use1920x1080(){
    global use_ksl_x, 1920x1080_ksl_x
    use_ksl_x=%1920x1080_ksl_x%
    global use_ksl_y, 1920x1080_ksl_y
    use_ksl_y=%1920x1080_ksl_y%
    global use_rbb_x, 1920x1080_rbb_x
    use_rbb_x=%1920x1080_rbb_x%
    global use_rbb_y, 1920x1080_rbb_y
    use_rbb_y=%1920x1080_rbb_y%
    global use_20h_x, 1920x1080_20h_x
    use_20h_x=%1920x1080_20h_x%
    global use_20h_y, 1920x1080_20h_y
    use_20h_y=%1920x1080_20h_y%
    global use_md_x, 1920x1080_md_x
    use_md_x=%1920x1080_md_x%
    global use_md_y, 1920x1080_md_y
    use_md_y=%1920x1080_md_y%
    global use_ly_x, 1920x1080_ly_x
    use_ly_x=%1920x1080_ly_x%
    global use_ly_y, 1920x1080_ly_y
    use_ly_y=%1920x1080_ly_y%
    global use_dq_x, 1920x1080_dq_x
    use_dq_x=%1920x1080_dq_x%
    global use_dq_y, 1920x1080_dq_y
    use_dq_y=%1920x1080_dq_y%
    global use_1st_x, 1920x1080_1st_x
    use_1st_x=%1920x1080_1st_x%
    global use_1st_y, 1920x1080_1st_y
    use_1st_y=%1920x1080_1st_y%
    global use_2nd_x, 1920x1080_2nd_x
    use_2nd_x=%1920x1080_2nd_x%
    global use_2nd_y, 1920x1080_2nd_y
    use_2nd_y=%1920x1080_2nd_y%
    global use_dysl_x, 1920x1080_dysl_x
    use_dysl_x=%1920x1080_dysl_x%
    global use_dysl_y, 1920x1080_dysl_y
    use_dysl_y=%1920x1080_dysl_y%
    global use_ddpw_x, 1920x1080_ddpw_x
    use_ddpw_x=%1920x1080_ddpw_x%
    global use_ddpw_y, 1920x1080_ddpw_y
    use_ddpw_y=%1920x1080_ddpw_y%
    global use_ygt_x, 1920x1080_ygt_x
    use_ygt_x=%1920x1080_ygt_x%
    global use_ygt_y, 1920x1080_ygt_y
    use_ygt_y=%1920x1080_ygt_y%
    global use_gly_x, 1920x1080_gly_x
    use_gly_x=%1920x1080_gly_x%
    global use_gly_y, 1920x1080_gly_y
    use_gly_y=%1920x1080_gly_y%
    global use_tbs_x, 1920x1080_tbs_x
    use_tbs_x=%1920x1080_tbs_x%
    global use_tbs_y, 1920x1080_tbs_y
    use_tbs_y=%1920x1080_tbs_y%
}


ExpeditionCharacter(targetPosX, targetPoxY, charPosX, charPosY){
    global use_ksl_x
    global use_ksl_y
    global use_rbb_x
    global use_rbb_y
    global use_20h_x
    global use_20h_y
    global use_md_x
    global use_md_y
    global use_ly_x
    global use_ly_y
    global use_dq_x
    global use_dq_y
    global use_1st_x
    global use_1st_y
    global use_2nd_x
    global use_2nd_y
    global use_dysl_x
    global use_dysl_y
    global use_ddpw_x
    global use_ddpw_y
    global use_ygt_x
    global use_ygt_y
    global use_gly_x
    global use_gly_y
    global use_tbs_x
    global use_tbs_y

    BlockInput, MouseMove
    Click %targetPosX%, %targetPoxY%
    Sleep 100 * sleepFactor
    Click %use_rbb_x%, %use_rbb_y% ; 领取
    Sleep 250 * sleepFactor
    Click ; 关闭 领取页
    Sleep 250 * sleepFactor
    Click %use_20h_x%, %use_20h_y% ; 20h
    Sleep 100 * sleepFactor
    Click %use_rbb_x%, %use_rbb_y% ; 选择角色
    Sleep 250 * sleepFactor
    Click %charPosX%, %charPosY%
    Sleep 250 * sleepFactor
    BlockInput, MouseMoveOff
}

ExpeditionAll(){
    global use_ksl_x
    global use_ksl_y
    global use_rbb_x
    global use_rbb_y
    global use_20h_x
    global use_20h_y
    global use_md_x
    global use_md_y
    global use_ly_x
    global use_ly_y
    global use_dq_x
    global use_dq_y
    global use_1st_x
    global use_1st_y
    global use_2nd_x
    global use_2nd_y
    global use_dysl_x
    global use_dysl_y
    global use_ddpw_x
    global use_ddpw_y
    global use_ygt_x
    global use_ygt_y
    global use_gly_x
    global use_gly_y
    global use_tbs_x
    global use_tbs_y

    Send, {f}
    Sleep 1000 * sleepFactor
    Send, {f}
    Sleep 1000 * sleepFactor
    Click %use_ksl_x%, %use_ksl_y% ; 蒙德 凯瑟琳
    Sleep 500 * sleepFactor

    ; 蒙德
    Click %use_md_x%, %use_md_y%
    Sleep 500 * sleepFactor

    ExpeditionCharacter(use_dysl_x, use_dysl_y, use_1st_x, use_1st_y) ; 低语森林     菲谢尔
    ExpeditionCharacter(use_ddpw_x, use_ddpw_y, use_2nd_x, use_2nd_y) ; 达达乌帕谷   班尼特

    ; 璃月
    Click %use_ly_x%, %use_ly_y%
    Sleep 500 * sleepFactor
    
    ExpeditionCharacter(use_ygt_x, use_ygt_y, use_1st_x, use_1st_y) ; 摇光滩   刻晴
    ExpeditionCharacter(use_gly_x, use_gly_y, use_2nd_x, use_2nd_y) ; 归离原   重云

    ; 稻妻
    Click %use_dq_x%, %use_dq_y%
    Sleep 800 * sleepFactor
    
    ExpeditionCharacter(use_tbs_x, use_tbs_y, use_1st_x, use_1st_y) ; 踏鞴砂  九条裟罗

    Sleep 400 * sleepFactor
    Send, {esc}
}