function A_hat = qua2real(A)
A_hat = [A(:,:,1),  -A(:,:,2), -A(:,:,3), -A(:,:,4); ...
         A(:,:,2),   A(:,:,1),  A(:,:,4), -A(:,:,3); ...
         A(:,:,3),  -A(:,:,4),  A(:,:,1),  A(:,:,2); ...
         A(:,:,4),   A(:,:,3), -A(:,:,2),  A(:,:,1)];