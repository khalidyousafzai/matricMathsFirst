% Octave requires a function that returns the gradient of the system, given the current state of the system, x and the time, t.

function xdot = sir_eqn(x,t)
    % Parameter values
    beta=0.1;
    mu=0.05;

    % Define variables
    s = x(1);
    y = x(2);
    r = x(3);

    % Define ODEs
    ds=-beta*s*y;
    dy=beta*s*y-mu*y;
    dr=mu*y;

    % Return gradients
    xdot = [ds,dy,dr];
endfunction

% We then set up the time axis over which to integrate and the initial conditions.

t = linspace(0, 200, 2001)+.1;
x0=[0.99,0.01,0];

% The function lsode can be used to solve ODEs of this form using Hindmarsh’s ODE solver LSODE.

x = lsode("sir_eqn",x0, t);

% The following saves the times and the states.
out=[transpose(t),x];
save -ascii sir_octave.out out;

!head sir_octave.out

% plot the solutions

plot(t,x(:,1),"-r",t,x(:,2),"-g",t,x(:,3),"-b")
xlim([0 200])
xlabel("Time","fontweight","bold")
ylabel("Number","fontweight","bold")
h = legend("S","I","R");
legend(h,"show")
