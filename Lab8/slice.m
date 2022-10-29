function [ out_sym ] = slice( in_sym, mod_type ) 
    in_sym = in_sym(:); 
    % BPSK
    if strcmp(mod_type,'BPSK')
        table=exp(1j*[0 -pi]);  % generates BPSK symbols
    % QPSK modulation
    elseif strcmp(mod_type,'QPSK')
        table=exp(1j*[-3/4*pi 3/4*pi 1/4*pi -1/4*pi]);  % generates QPSK symbols
    % 16-QAM modulation
    elseif strcmp(mod_type,'16QAM')
        % generates 16QAM symbols
        m=1;
        for k=-3:2:3
            for l=-3:2:3
                table(m) = (k+1j*l)/sqrt(10); % power normalization
                m=m+1;
            end
        end
    % 64-QAM modulation
    elseif strcmp(mod_type,'64QAM')
        % generates 64QAM symbols
        m=1;
        for k=-7:2:7
            for l=-7:2:7
                table(m) = (k+1j*l)/sqrt(42); % power normalization
                m=m+1;
            end
        end
    else
        error('Unimplemented modulation');
    end 
    out_sym = zeros(length(in_sym),1);
    d = zeros(1,length(table));
    for n_sym = 1:length(in_sym)
        for n_d = 1:length(d)
            d(n_d) = abs(in_sym(n_sym) - table(n_d));
        end
        [m,index] = min(d);
        out_sym(n_sym) = table(index);
    end