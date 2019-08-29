#!/usr/bin/env python3
"""This script is used for plotting scatter plot between effect size and frequency for disease variant. A regression line is also generated"""

import pandas as pd
from plotnine import *

df1 = pd.read_excel('table1.xlsx')
df2 = pd.read_excel('table2.xlsx')

a = (ggplot(df1) +
    aes(x='Freq*(1-Freq)', y='Beta') + 
    geom_point(size=2,show_legend=False) +
    xlim(0.1,0.25) +
    ylim(0.5,4) +
    labs(x = 'Freq(1-Freq)',
        y = 'Beta (msec)',
        ) +
    geom_smooth(method='lm')
    )

b = (ggplot(df2) +
    aes(x='Freq*(1-Freq)', y='Beta') + 
    geom_point(size=2,show_legend=False) +
    xlim(0.1,0.25) +
    ylim(0.5,4) +
    labs(x = 'Freq(1-Freq)',
        y = 'Beta (msec)',
        ) +
    geom_smooth(method='lm')
    )

a.save("figure1.png",height=100, width=100, units = 'mm', dpi=600)
b.save("figure2.png",height=100, width=100, units = 'mm', dpi=600)
