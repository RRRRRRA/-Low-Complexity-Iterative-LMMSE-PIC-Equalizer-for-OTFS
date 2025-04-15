N = 64;
M = N;

delay_vec = [0 1 0 0]; %signle path delay and Doppler (nLOS) 
dop_vec = [0 1 0 0];

mode = input('mode: Enter 0 for d-D impulse, 1 for chirp, 2 for xchirp : ');

in_delay = input('delay: Enter delay value : ');
in_doppler = input('Doppler: Enter Doppler value : ');
nTrials = input('number of iterations : ');

delay_pos = [1 1+in_delay 15 31];
dop_val = in_doppler;

correct_d_D = zeros(1,length(-40:0.5:-15));
count = 0;
tic;
for n = -40 : 0.5 : -15
    count = count + 1;
    snr_db = n;
    for i = 1 : nTrials
        [xrx,chirp,invchirp,xchirp,impulse_dD] = gen_otfs(delay_vec,delay_pos,dop_vec,dop_val,mode,snr_db,N);
        calc_d_D; %calculate delay and Doppler values
    if delay == in_delay
        if doppler == in_doppler
            correct_d_D(1,count) = 1 + correct_d_D(1,count); %check if d-D values are correct
        end 
    end
    end
end
toc;
p_error = (nTrials - correct_d_D)/nTrials ;
% figure;
plot(-40:0.5:-15,p_error);
