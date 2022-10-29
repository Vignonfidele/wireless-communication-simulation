function [Q,R] = QR_decomp(A) 
    [L,J] = size(A); 
    Q = zeros(L,J);
    R = zeros(J);
    Q(1:L,1) = A(1:L,1);
    R(1,1) = 1; 
    for i=1:J  
        R(i,i) = norm(A(1:L,i));
        Q(1:L,i) = -A(1:L,i)/R(i,i);
        j=(i+1:J);
        R(i,j) = Q(1:L,i)'*A(1:L,j);
        A(1:L,j) = A(1:L,j)-Q(1:L,i)*R(i,j);   
    end
    R(1:J+1:end) = -R(1:J+1:end);
end