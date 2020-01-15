% cv2_min = min(cv2')';
cv_min = min(cv')';
cv_draft = zeros(size(cv));
for ii = 1:length(cv_min)
    cv_draft(ii, :) = cv(ii, :) - cv_min(ii, 1)*ones(1, size(cv, 2));
end

x = (1:23)';
xi = (1:0.015:23)';
cv_draft_intp = zeros(length(xi), size(cv_draft, 2));
for ii = 1:size(cv_draft, 2)
    Y = cv_draft(:, ii);
    cv_draft_intp(:, ii) = interp1q(x,Y,xi);
end
%%
cv_1cy = cv_draft_intp;
%%
figure('color','white');
imshow(cv_1cy, 'DisplayRange',[], 'InitialMagnification', 'fit');
colormap jet
% figure('color','white');
% imshow(log(cv3_1cy(:, 1:end)), 'DisplayRange',[], 'InitialMagnification', 'fit');
% colormap jet
%%
axis on

xlabel('Wavelength (nm)')
ylabel('Potential (V vs. Ag/AgCl)')
h = colorbar;
set(get(h, 'title'), 'string', 'Count', 'FontSize', 8);
%%
cv_diff = zeros(size(cv_1cy, 1)-1, size(cv_1cy, 2));
for ii = 1:size(cv_1cy, 1)-1
    cv_diff(ii, :) = cv_1cy(ii+1, :) - cv_1cy(ii, :);
end
%%
figure('color','white');
imshow(cv_diff(:, 1:end), 'DisplayRange',[], 'InitialMagnification', 'fit');
colormap jet

%%
figure('color','white');
ii = 1;
% line = smooth(cv2(ii, :), 10);
plot(X, cv(ii,:));
% findpeaks(cv2(ii,:), X, 'MinPeakDistance',20)
% xlim([50 600])
%%
peakinfo{ii, 1} = cursor_info;

%%
figure('color','white');
% for ii  = 1:size(cv2, 1)
    ii = 8;
    temp = cv2(ii, :);
    Y = (temp - min(temp)*ones(1, length(temp)))./(max(temp) - min(temp));
    plot(X, Y)
%     hold on
% end
set(findobj(get(gca, 'Children'), 'LineWidth',0.5), 'LineWidth', 2);
set(gca, 'linewidth', 1.5)
xlim([50 500])
legend(num2str(ii));
hold off
%%
RamanPeakPosition = zeros(size(cv2, 1), 7);
%%
for jj = 1:7
    temp = cursor_info(jj).Position;
    RamanPeakPosition(ii, jj) = temp(1);
end