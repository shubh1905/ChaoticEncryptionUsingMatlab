v=imread('D:\image1.png');
A=double(rgb2gray(v));
A2=double(imread('D:\enc.png'));
    %hprizontal
    x1 = A(:,1:end-1);  
    y1 = A(:,2:end);
    kyatayO=hesap(x1,y1)
    %Vertical
    x2 = A(1:end-1,:);  
    y2 = A(2:end,:);    
    kdikeyO=hesap(x2,y2)
    %diagonal
    x3 = A(1:end-1,1:end-1);  
    y3 = A(2:end,2:end);     
    kkosegenO=hesap(x3,y3)

    %==================================================
    %for encrypted image
    %horizontal
    x4 = A2(:,1:end-1);  
    y4 = A2(:,2:end);
    kyatayI=hesap(x4,y4)
    %Vertical
    x5 = A2(1:end-1,:);  
    y5 = A2(2:end,:);    
    kdikeyI=hesap(x5,y5)
    %diagonal
    x6 = A2(1:end-1,1:end-1);  
    y6 = A2(2:end,2:end);     
    kkosegenI=hesap(x6,y6)
    %==================================================
    %graphics
    h=figure;
    subplot(3,2,1),grafik(x1,y1),title('Horizontal');
    subplot(3,2,3),grafik(x2,y2),title('Vertical');
    subplot(3,2,5),grafik(x3,y3),title('Diagonal');
    subplot(3,2,2),grafik(x4,y4),title('Horizontal');
    subplot(3,2,4),grafik(x5,y5),title('Vertical');
    subplot(3,2,6),grafik(x6,y6),title('Diagonal');
    saveas(h,'correlationGray.jpg');
    