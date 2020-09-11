iptsetpref('UseIPPL', false);
img = imread('xskuto00.bmp');

%zaostreni obrazku
 H = [-0.5 -0.5 -0.5; -0.5 5.0 -0.5; -0.5 -0.5 -0.5]
 img2 = imfilter(img, H);
 imwrite(img2, 'step1.bmp');
 
%preklopeni zaostreneho obrazku kolem svisle osy
 img3 = fliplr(img2);
 imwrite(img3, 'step2.bmp');
 
%medianovy filtr
 img4 = medfilt2(img3, [5 5]);
 imwrite(img4, 'step3.bmp');
 
%rozmazani obrazu
 H2 = [1 1 1 1 1; 1 3 3 3 1; 1 3 9 3 1; 1 3 3 3 1; 1 1 1 1 1] / 49;
 img5 = imfilter(img4, H2);
 imwrite(img5, 'step4.bmp');
 
%chyba v obraze
 img5_a = fliplr(img5);
 imgd = double(img);
 imgd5_a = double(img5_a);
 noise = 0;
 for (x = 1 : 512)
     for (y = 1 : 512)
         noise = noise + abs(imgd(x, y) - imgd5_a(x, y));
     end;
 end;
 noise = noise/512/512
 
%roztazeni histogramu
imgd6 = double(img5);
 minimum = min(min(imgd6));
 maximum = max(max(imgd6));
 interval = 255;
 img6_a = imadjust(img5, [minimum/interval maximum/interval], [0.0 1.0]);
 img6 = uint8(img6_a);
 imwrite(img6, 'step5.bmp');
 
%stredni hodnota a smerodatna odchylka
 imgd7 = double(img5);
 imgd8 = double(img6);
 mean_no_hist = mean(mean(imgd7))
 std_no_hist = std2(imgd7)
 mean_hist = mean(mean(imgd8))
 std_hist = std2(imgd8)
 
%kvantizace obrazu
a = 0;
b = 255;
N = 2;
imgd9 = double(img6);
x = size(img6);
img10_a = zeros(x(1), x(2));
for k = 1 : x(1)
    for l = 1 : x(2)
        img10_a(k, l) = round(((2 ^ N) - 1) * (imgd9(k, l) - a) / (b - a)) * (b - a) / ((2 ^ N) - 1) + a;
    end
end
img10 = uint8(img10_a);
imwrite(img10, 'step6.bmp');


 
 
 
 
         
 
 


 
 