function [p_rank] = boxplot_conVtcb(con_perc_change,tcb_perc_change,y_axis_label,x_axis_labels)
  
  p_rank = round(ranksum(con_perc_change,tcb_perc_change),3);

  boxplot([con_perc_change' tcb_perc_change'],'Color','k','Symbol','');
  ylabel(['\Delta ' y_axis_label ' (%)']);
  h = findobj(gca,'Tag','Box');
  fill_color = [1 0 0; 0 0 0];
  for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),fill_color(j,:),'FaceAlpha',.25,'EdgeColor',fill_color(j,:),'LineWidth',2);
  end
  hold on
  if p_rank < 0.05
   sigstar({[1 2]},p_rank);
  end
  x_val = ones(numel(con_perc_change),1);
  plot(x_val,con_perc_change,'o','MarkerFaceColor','k');
  x_val = x_val+1;
  plot(x_val,tcb_perc_change,'o','MarkerFaceColor','r');
  hold off
  set(gca,'XTickLabel',x_axis_labels);
  if p_rank == 0
   title(['p < 0.001'])
  end
  title(['p = ' num2str(p_rank)]);
  box off
end