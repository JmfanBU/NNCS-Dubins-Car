# NNCS-Dubins-Car
This repository contains NNCSs of dubins car control. The environment is a hallway with one corner. The controller drives the vehicle to turn at the first corner and avoids the obstacle in the middle of the hallway. The code is implemented in MATLAB.

## Simulation of NNCS

Open Matlab and run

```
simulate_with_NN_*
```
Replace the star part with the different suffix of .m file.

## Neural-Network Controller
Six different networks are provided in this repo. Three of them use tanh activation functions, and three of them use various activation functions (ReLU-tanh). The main difference between them is the value of Lipschitz constant. The networks are stored in NN. The format is as follows:
```
3 // number of inputs
1 // number of outputs
2 // number of hidden layers
20 // number of nodes in the first hidden layer
20 // number of nodes in the second hidden layer
// Weights of the first hidden layer
-0.0073867239989340305
...
0.014101211912930012
// Bias of the first hidden layer
-0.07480818033218384
...
0.29650038480758667
...
```

The utilization of network is as follows:
```
u = NN_output_ACTIVATION(INPUT, 0, 1,'NN/NETWORK_FILE');
```

Here ACTIVATION is the type of activation function. INPUT is the current state of the system. NETWORK_FILE is the name of the stored network.

## Dynamics of Dubins Car

The function for dynamics of the dubins car model is in system_eq_dis.m
