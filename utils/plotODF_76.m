function plotODF_76(fname,plotname1,colnum)
ODF = load(fname);
%figure()
FigH = figure('Position', get(0, 'Screensize'),'visible','off');
ODF = getFullODF(ODF);
[~,co,el] = readtecplotODF('ODF.out',145);

[lenp,~] = size(ODF);
%lenp = 3
cmax = max(ODF(:));
cmin = min(ODF(:));
Xbig= [];
Ybig= [];
Zbig= [];

n=int16(colnum)

rows = int16(fix(lenp/n))
for kk = 1:lenp
    kk
    subplot(4,5,kk);
    hold on
    colormap jet(256);
    temp_vec = ODF(kk,:);


    Cbig= [];
    d = [1 1 1 4;2 4 4 2;3 3 2 3];

    for i = 1:length(el)
        if kk == 1
            X = [co(el(i,1),1);co(el(i,2),1);co(el(i,3),1);co(el(i,4),1)];
            Y = [co(el(i,1),2);co(el(i,2),2);co(el(i,3),2);co(el(i,4),2)];
            Z = [co(el(i,1),3);co(el(i,2),3);co(el(i,3),3);co(el(i,4),3)];
            Xbig = [Xbig X(d)];
            Ybig = [Ybig Y(d)];
            Zbig = [Zbig Z(d)];
        end
        for j = 1:3
            for k = 1:4
                S(j,k) = el(i,d(j,k));
            end
        end
        Cbig = [Cbig temp_vec(S)];
    end
    fill3(Xbig,Ybig,Zbig,Cbig,'EdgeColor','none');
    view(3);
    axis equal;axis off
    caxis([cmin cmax]);
   hold off;
end
F    = getframe(FigH);
whitebg('k');
saveas(FigH, plotname1,'png')
%export_fig(plotname1, '-png', '-transparent')

FigH = figure('Position', get(0, 'Screensize'),'visible','off');
    colormap jet(256);
    temp_vec = ODF(lenp,:);


    Cbig= [];
    d = [1 1 1 4;2 4 4 2;3 3 2 3];

    for i = 1:length(el)
        if kk == 1
            X = [co(el(i,1),1);co(el(i,2),1);co(el(i,3),1);co(el(i,4),1)];
            Y = [co(el(i,1),2);co(el(i,2),2);co(el(i,3),2);co(el(i,4),2)];
            Z = [co(el(i,1),3);co(el(i,2),3);co(el(i,3),3);co(el(i,4),3)];
            Xbig = [Xbig X(d)];
            Ybig = [Ybig Y(d)];
            Zbig = [Zbig Z(d)];
        end
        for j = 1:3
            for k = 1:4
                S(j,k) = el(i,d(j,k));
            end
        end
        Cbig = [Cbig temp_vec(S)];
    end
    fill3(Xbig,Ybig,Zbig,Cbig,'EdgeColor','none');
    view(3);

axis equal;axis off
    caxis([cmin cmax]);
c=colorbar %common colorbar in the last ODF
c.FontSize = 20
    saveas(FigH, strcat('colorbar',plotname1),'png')
    %export_fig(strcat('colorbar',plotname1), '-png', '-transparent')
 end

function [odf,co,el] = readtecplotODF(filename,numnodes)
%odf = readtecplotODF(filename,numnodes)
%return the ODF as a column vector, the input tecplot file is given in
%'filename' and 'numnodes' is the number of nodes in the fundamental region

a = textread(filename,'%*f%*f%*f%f','delimiter','\t','headerlines',4);
odf = a(1:numnodes);
[a,b,c] = textread(filename,'%f%f%f%*f','delimiter','\t','headerlines',4);
co = [a(1:numnodes)';b(1:numnodes)';c(1:numnodes)']';
[a,b,c,d] = textread(filename,'%f%f%f%f','delimiter','\t','headerlines',4+numnodes);
el = [a';b';c';d']';
end

function ODFs=getFullODF(ODF76)
  symms = load('ODFsym.txt');
  [numODF,~] = size(ODF76);
  ODFs = zeros(numODF,145);
  for i = 1:numODF;
    ODFs(i,1:76) = ODF76(i,1:76);
    ODFs(i,symms(:,1))=ODF76(i,symms(:,2));
  end
end
