# EvoGam
just some code

> Create a sample MVC(S) Robotlegs project

- I never used Robotlegs, Flex Unit (used tests in Ruby and Python) and Maven (used Ant only), so I spent more time than it was planned to read about it. 
Sorry, but I don't have enough time now to learn maven for test task (spent it to learn RL and Flex Unit). So there is no Maven configuration. 

> Write method that takes two sorted arrays of integers

- In utils.ArrayUtils you can find function to merge sorted arrays. 

> Explain what does this code do

This code should print odd numbers;

> How it works

e4x magic

> what’ s wrong with it

You used 0x00A0 symbol (nbsp), which was interpreted as xml node, that not contains @myVal property. Ther is 2 ways to fix it: 
1. Iterate over "node" children like: xmlData.node.(@myVal % 2 && trace(@myVal));
2. Replace nbsp to space or tab.

