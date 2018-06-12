//
//  YYFilterColorMatrix.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/6/12.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

/*
[ a, b, c, d, e,
  f, g, h, i, j,
  k, l, m, n, o,
  p, q, r, s, t ]

a, b, c, d, e 表示三原色中的红色
f, g, h, i, j 表示三原色中的绿色
k, l, m, n, o 表示三原色中的蓝色
p, q, r, s, t 表示颜色的透明度
第五列用于表示颜色的偏移量
*/

//test
var colormatrix_test: [Float] = [
    1.0, 0.0, 0.0, 22.0, 0,
    0.0, 1.1, 12.0, 0.0, -66.6,
    0.0, 0.0, -20.0, 0.0, -66.6,
    0.0, 0.0, 0.0, 1.0, 0.0
]

//黑白
var colormatrix_heibai: [Float] = [
    0.8,  1.6, 0.2, 0, -163.9,
    0.8,  1.6, 0.2, 0, -163.9,
    0.8,  1.6, 0.2, 0, -163.9,
    0,  0, 0, 1.0, 0
]

//LOMO
var colormatrix_lomo: [Float] = [
    1.7,  0.1, 0.1, 0, -73.1,
    0,  1.7, 0.1, 0, -73.1,
    0,  0.1, 1.6, 0, -73.1,
    0,  0, 0, 1.0, 0
]

//复古
var colormatrix_huajiu: [Float] = [
    0.2,0.5, 0.1, 0, 40.8,
    0.2, 0.5, 0.1, 0, 40.8,
    0.2,0.5, 0.1, 0, 40.8,
    0, 0, 0, 1, 0 ]

//哥特
var colormatrix_gete: [Float] = [
    1.9,-0.3, -0.2, 0,-87.0,
    -0.2, 1.7, -0.1, 0, -87.0,
    -0.1,-0.6, 2.0, 0, -87.0,
    0, 0, 0, 1.0, 0
]

//锐化
var colormatrix_ruihua: [Float] = [
    4.8,-1.0, -0.1, 0,-388.4,
    -0.5,4.4, -0.1, 0,-388.4,
    -0.5,-1.0, 5.2, 0,-388.4,
    0, 0, 0, 1.0, 0
]


//淡雅
var colormatrix_danya: [Float] = [
    0.6,0.3, 0.1, 0,73.3,
    0.2,0.7, 0.1, 0,73.3,
    0.2,0.3, 0.4, 0,73.3,
    0, 0, 0, 1.0, 0
]

//酒红
var colormatrix_jiuhong: [Float] = [
    1.2,0.0, 0.0, 0.0,0.0,
    0.0,0.9, 0.0, 0.0,0.0,
    0.0,0.0, 0.8, 0.0,0.0,
    0, 0, 0, 1.0, 0
]

//清宁
var colormatrix_qingning: [Float] = [
    0.9, 0, 0, 0, 0,
    0, 1.1,0, 0, 0,
    0, 0, 0.9, 0, 0,
    0, 0, 0, 1.0, 0
]

//浪漫
var colormatrix_langman: [Float] = [
    0.9, 0, 0, 0, 63.0,
    0, 0.9,0, 0, 63.0,
    0, 0, 0.9, 0, 63.0,
    0, 0, 0, 1.0, 0
]

//光晕
var colormatrix_guangyun: [Float] = [
    0.9, 0, 0,  0, 64.9,
    0, 0.9,0,  0, 64.9,
    0, 0, 0.9,  0, 64.9,
    0, 0, 0, 1.0, 0
]

//蓝调
var colormatrix_landiao: [Float] = [
    2.1, -1.4, 0.6, 0.0, -31.0,
    -0.3, 2.0, -0.3, 0.0, -31.0,
    -1.1, -0.2, 2.6, 0.0, -31.0,
    0.0, 0.0, 0.0, 1.0, 0.0
]

//梦幻
var colormatrix_menghuan: [Float] = [
    0.8, 0.3, 0.1, 0.0, 46.5,
    0.1, 0.9, 0.0, 0.0, 46.5,
    0.1, 0.3, 0.7, 0.0, 46.5,
    0.0, 0.0, 0.0, 1.0, 0.0
]

//夜色
var colormatrix_yese: [Float] = [
    1.0, 0.0, 0.0, 0.0, -66.6,
    0.0, 1.1, 0.0, 0.0, -66.6,
    0.0, 0.0, 1.0, 0.0, -66.6,
    0.0, 0.0, 0.0, 1.0, 0.0
]


