<div align="center">
<h1>Coroutines for GML</h1>
<h4>Asynchronous code execution for GameMaker v2024 and above.<br><br>
<a href=https://github.com/HannulaTero/GameMaker-Coroutine/releases>Download package</a><br>
<a href=https://github.com/HannulaTero/GameMaker-Coroutine/wiki>Documentation</a><br>
</h4></div><br>
<p>
<div align="left">
This is another coroutine system for GameMaker, hopefully you find joy from this :) <br> 
If you are familiar with <a href=https://github.com/JujuAdams/Coroutines>JujuAdams' Coroutines</a>, then you will feel right at home here. 
The syntax draws inspiration from Juju, so on the surface they work similarly. 
However, this is not a fork. Instead it has been separately written, and includes fundamental differences. 
<br><br>
So what makes this any different?<br>
Well this system tries to expand possiblities how you can define coroutine. 
Most notably, triggers. You can define triggers for certain times for coroutine execution, such what it will always do when it yields, or is resumed from paused state. Or what it will do when it is finished. 
These are required, if you want to be able to use coroutines for drawing, so you can change GPU states, surfaces and shaders whenever coroutine yields and resumes.
Because coroutines asynchronous nature, I don't recommend them for general rendering, but instead if you are doing something fancy with shaders, as hacking fragment shaders for general computing. And well that's one reason why I wrote this.
This also expands with new statements, such as SWITCH and GOTO, and provides bit different way handling the asynchronous requests.

<br><br>
About compatibility.<br>
This coroutine system has been developed in GameMaker v2024.8, and is intended to work in that or higher.
But I have briefly tested this with GameMaker LTS2022, it doesn't work out of the box. But if you accommodate missing features, it mostly works. For LTS, the most problematic is implementation of FOREACH. 
And how about HTML5? Well, it "worked" at some point, but currently it gives out errors. Might fix those later. 
</p>
