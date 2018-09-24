#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Sep 22 12:26:44 2018

@author: akshaygovindaraj
"""

import pandas as pd

from scipy.stats import f_oneway
from scipy.stats import friedmanchisquare

stock_df = pd.read_csv('enrichment_projects/ep1/data/Friedman.csv')

treatment1 = stock_df.values[:,1]
treatment2 = stock_df.values[:,2]
treatment3 = stock_df.values[:,3]

stat, p = friedmanchisquare(treatment1, treatment2, treatment3)
print('Statistics=%.3f, p=%.3f' % (stat, p))

# interpret
alpha = 0.05
if p > alpha:
	print('Same distributions (fail to reject H0)')
else:
	print('Different distributions (reject H0)')
    
    
#Performing the f test

stat, p = f_oneway(treatment1, treatment2, treatment3)

print('Statistics=%.3f, p=%.3f' % (stat, p))

# interpret
alpha = 0.05
if p > alpha:
	print('Same distributions (fail to reject H0)')
else:
	print('Different distributions (reject H0)')