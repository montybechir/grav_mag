%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Lab 5

load('goph_547_w2016_lab4_data.mat');

%Part 1
%Plot a 2D Contour plot data plot
figure;
contourf(X,Y,Fz_raw);
h_c = colorbar;
ylabel(h_c,'[Fz(nT)]','fontweight','bold');
title('2-D Contour Plot of Raw Fz Data ');
xlabel('X(m)');
ylabel('Y(m)');


%Plot Fz versus X Plot
figure;
plot(X,Fz_raw,'bo');
title('Fz vs X Plot');
xlabel('X(m)');
ylabel('Fz(nT)');

figure;
plot(Y,Fz_raw,'bo');
title('Fz vs Y Plot');
xlabel('Y(m)');
ylabel('Fz(nT)');

%Part 2
%Find the coefficients of the linear trendline 
Py=polyfit(Y, Fz_raw,1);
%Create equation 
PyVal=polyval(Py,Y)

%Add the polyfit to the Fz vs  Y plot 
figure;
plot(Y,Fz_raw,'bo');
hold on
plot(Y,PyVal,'--r');
title('Fz vs Y Plot with Trendline');
xlabel('Y(m)');
ylabel('Fz(nT)');


%part3
%Remove the linear component of Fz vs Y 
for i=1:11
    for j=1:16
        Fz_raw(i,j)=Fz_raw(i,j)-0.069901515151515*Y(i,j);
    end
end

figure;
plot(Y,Fz_raw,'bo');
title('Fz vs Y Linear Varitions Removed in Y Plot');
xlabel('Y(m)');
ylabel('Fz(nT)');

%Plot Fz versus X 
figure;
plot(X,Fz_raw,'bo');
title('Fz vs X Linear Variations Removed in Y');
xlabel('X(m)');
ylabel('Fz(nT)');

%Plot a 2D Contour plot data plot
figure;
contourf(X,Y,Fz_raw);
h_c = colorbar;
ylabel(h_c,'[Fz(nT)]','fontweight','bold');
title('2-D Contour Plot of Fz Data After Linear Y Component Removal');
xlabel('X(m)');
ylabel('Y(m)');


%Part 4
%Find the coefficients of the linear line of best fit
Px=polyfit(X, Fz_raw,1);
%Create equation 
PxVal=polyval(Px,X);

%Add the polyfit to the Fz vs X plot 
figure;
plot(X,Fz_raw,'bo');
hold on
plot(X,PxVal,'--ro');
title('Fz vs X Plot with Trendline');
xlabel('X(m)');
ylabel('Fz(nT)');

%Remove the linear component of Fz vs X
for i=1:11
    for j=1:16
        Fz_raw(i,j)=Fz_raw(i,j)-(Px(1)*X(i,j));
    end
end

%Plot Fz vs X after linear variations are removed in x
figure;
plot(X,Fz_raw,'bo');
title('Fz vs X Linear Varitions Removed in X Plot');
xlabel('X(m)');
ylabel('Fz(nT)');

%Plot Fz versus Y 
figure;
plot(Y,Fz_raw,'bo');
title('Fz vs Y Linear Variations Removed in X Plot');
xlabel('X(m)');
ylabel('Fz(nT)');

%Plot a 2D Contour plot data
figure;
contourf(X,Y,Fz_raw);
h_c = colorbar;
ylabel(h_c,'[Fz(nT)]','fontweight','bold');
title('2-D Contour Plot of Fz Data After Linear X Component Removal');
xlabel('X(m)');
ylabel('Y(m)');


%Part 5
%find minimum of the regional values in Fz
ConstantVal=min(min(Fz_raw));
%remove the constant regional Fz from all points
for i=1:11
    for j=1:16
        Fz_raw(i,j)=Fz_raw(i,j)-ConstantVal;
    end
end

%Plot a contourplot after constant component of the regional is removed
figure;
contourf(X,Y,Fz_raw);
h_c = colorbar;
ylabel(h_c,'[Fz(nT)]','fontweight','bold');
title('Constant Regional Effects Eliminated Fz Contour Plot ');
xlabel('X(m)');
ylabel('Y(m)');

%part 6
%Data needed for upward continuation
Nx=length(X);
dx=30;
xmin=0;
xmax=450;
ymin=0;
ymax=300
Ny=length(Y);
dy=30;
h=30;
x2=X;
y2=Y;
Fz_upward_continued=zeros(11,16);

%Compute upward continuation using a double integral
for i=1:11
    for j=1:16
        %create function with respect to x and y to be integrated
        fun=@(x,y)(Fz_raw(i,j).*h)./((((x-x2(i,j)).^2+(y-y2(i,j)).^2+(h^2)).^(3/2)).*2.*pi);
        %compute the integration using the integral formula 
        Fz_upward_continued(i,j)= integral2(fun,xmin,xmax,ymin,ymax); 
    end
end

%Create Contour Plot after data is upward continued 
figure;
contourf(X,Y,Fz_upward_continued);
h_c = colorbar;
ylabel(h_c,'[Fz(nT)]','fontweight','bold');
title('Contour Plot of Upward Continued Magnetic Data ');
xlabel('X(m)');
ylabel('Y(m)');

%Part 7
%compute downward continuation using finite difference approximation
%initialize the downward continued matrix
Fz_downward_continued=zeros(11,16);
for i=2:10
    for j=2:15
        Fz_downward_continued(i,j)=(6*Fz_raw(i,j))-(Fz_raw(i,j+1)+Fz_raw(i,j-1)+Fz_raw(i-1,j)+Fz_raw(i+1,j+1)+Fz_upward_continued(i,j));
    end
end

figure;
contourf(X,Y,Fz_downward_continued);
h_c = colorbar;
ylabel(h_c,'[Fz(nT)]','fontweight','bold');
title('Contour Plot of Downward Continued Magnetic Data ');
xlabel('X(m)');
ylabel('Y(m)');
        



