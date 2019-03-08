#!usr/bin/python
""" fit NLLS models """

__author__ = 'Shiyun Liu s.liu18@imperial.ac.uk'
__version__ = '0.0.1'

import pandas as pd 
import numpy as np
import lmfit
from lmfit import minimize, Parameters, Parameter, report_fit

#read in the data
DF = pd.read_csv('../Result/Data.csv')


###################Fitting cubic model
#define the residual function
def residual1(params, x, data):
    """ calculate residual for cubic model """
    #get the value of the params from a dict
    parvals = params.valuesdict()
    a = parvals['a']
    b = parvals['b']
    c = parvals['c']
    d = parvals['d']
    model = a + b*x + c*x**2 + d*x**3
    return data - model

#creat DF to store cubic model fitting
cubicDF = pd.DataFrame()

#start the model fitting
#group the DF by GroupID, using groupby function in pandas
#group. or g['']
for name, group in DF.groupby('GroupID'):

    #get x and y value
    x = group.KTemp    
    y = group.OriginalTraitValue 

    #give initial parameter, cubic model try with all 0
    params = Parameters()
    params.add('a', value= 0)
    params.add('b', value= 0)
    params.add('c', value= 0)
    params.add('d', value= 0)

    #model fitting with least square method (using minimize)
    #use try-except function becuase not all models converge
    try:
        result = minimize(residual1, params, args=(x,y))

        #store the result
        P1 = result.params['a'].value
        P2 = result.params['b'].value
        P3 = result.params['c'].value
        P4 = result.params['d'].value
        AIC = result.aic
        Converge = "Y"
        
        #indicate the convergance result
        print (name, "Yes")

    except ValueError:
        #when encounter value error means convergance failed
        
        #put NA to the results for models that don't converge
        P1 = "NA"
        P2 = "NA"
        P3 = "NA"
        P4 = "NA"
        AIC = "NA"
        Converge = "N"
        
        #indicate the convergance result
        print (name, "No")
    
    #save the result to cubic DF
    #pd.DataFrame either use list[], or pass an index, i.e.index=[0]
    output = pd.DataFrame({"GroupID": [name], "a": [P1], "b": [P2], "c": [P3], "d": [P4], "AIC": [AIC], "Converge": [Converge]})
    cubicDF = cubicDF.append(output)

cubicDF.head(n=10)
#save the cubic DF to csv
cubicDF.to_csv('../Result/cubic_model.csv')
#all of the models converged

###################Fitting Briere model
def residual2(params, x, data):
    """ calculate residual for briere model """
    #get the value of the params from a dict
    parvals = params.valuesdict()
    B0 = parvals['B0']
    Tm = parvals['Tm']
    T0 = parvals['T0']
    model = B0*x*(x-T0)*((Tm-x)**0.5)
    return data - model

#creat DF to store briere model fitting
briereDF = pd.DataFrame()

#start the model fitting
#group the DF by GroupID, using groupby function in pandas
#group. or g['']
for name, group in DF.groupby('GroupID'):

    #get x and y value
    x = group.KTemp    
    y = group.OriginalTraitValue 

    #give initial parameter, B0 as a normalization constant giving a 0 as initial
    params = Parameters()
    params.add('B0', value= 0)
    params.add('Tm', value= group.Tm.iloc[0])
    params.add('T0', value= group.T0.iloc[0])

    #model fitting with least square method (using minimize)
    #use try-except function becuase not all models converge
    try:
        result = minimize(residual2, params, args=(x,y))

        #store the result
        P1 = result.params['B0'].value
        P2 = result.params['Tm'].value
        P3 = result.params['T0'].value
        AIC = result.aic
        Converge = "Y"
        
        #indicate the convergance result
        print (name, "Yes")

    except ValueError:
        #when encounter value error means convergance failed
        
        #put NA to the results for models that don't converge
        P1 = "NA"
        P2 = "NA"
        P3 = "NA"
        AIC = "NA"
        Converge = "N"
        
        #indicate the convergance result
        print (name, "No")
    
    #save the result to cubic DF
    #pd.DataFrame either use list[], or pass an index, i.e.index=[0]
    output = pd.DataFrame({"GroupID": [name], "B0": [P1], "Tm": [P2], "T0": [P3], "AIC": [AIC], "Converge": [Converge]})
    briereDF = briereDF.append(output)

briereDF.head(n=10)
#save the cubic DF to csv
briereDF.to_csv('../Result/briere_model.csv')


###################Fitting Schoolfield model (unsimplified)
#get the constant value
k = 8.617e-05

#define the residual function
def residual3(params, x, data):
    """ calculate residual for Schoolfield model """
    #get the value of the params from a dict
    parvals = params.valuesdict()
    B0 = parvals['B0']
    E = parvals['E']
    Eh = parvals['Eh']
    El = parvals['El']
    Th = parvals['Th']
    Tl = parvals['Tl']
    model = np.log((B0*np.exp((-E/k)*((1/x)-(1/283.15)))) / (1+(np.exp((El/k)*((1/Tl)-(1/x))))+(np.exp((Eh/k)*((1/Th)-(1/x))))))
    return data - model

#creat DF to store schoolfield model fitting
schoolfieldDF = pd.DataFrame()

#start the model fitting
#group the DF by GroupID, using groupby function in pandas

for name, group in DF.groupby('GroupID'):

    #get x and y value
    x = group.KTemp
    y = group.LogTraitValue

    #give initial parameter
    #.iloc to get the nth of the list
    params = Parameters()
    params.add('B0', value= group.B0.iloc[0])
    params.add('E', value= abs(group.E.iloc[0]))
    params.add('Eh', value= abs(group.Eh.iloc[0]))
    params.add('El', value= abs(group.El.iloc[0]))
    params.add('Th', value= group.Th.iloc[0])
    params.add('Tl', value= group.Tl.iloc[0])
    
    if len(x) > 5:

        try:
            result = minimize(residual3, params, args=(x, y))

            #assign all variables to make a dataframe
            P1 = result.params['B0'].value
            P2 = result.params['E'].value
            P3 = result.params['Eh'].value
            P4 = result.params['El'].value
            P5 = result.params['Th'].value
            P6 = result.params['Tl'].value

            Converge = "Y"

            #get the un-logged version of AIC
            model = np.log((P1*np.exp((-P2/k)*((1/x)-(1/283.15)))) / (1 + (np.exp((P4/k)*((1/P6)-(1/x)))) + (np.exp((P3/k)*((1/P5)-(1/x))))))
            yhat = np.exp(y) - np.exp(model)
            SSR = np.sum(((yhat)**2))
            AIC = (2*6 + len(x)*np.log(SSR/len(x)))

            #indicate the convergance result
            print (name, "Yes")
    
        except ValueError:
            #when encounter value error means convergance failed
            #put NA to the results for models that don't converge
            P1 = "NA"
            P2 = "NA"
            P3 = "NA"
            P4 = "NA"
            P5 = "NA"
            P6 = "NA"
        
            AIC = "NA"
            Converge = "N"
        
            #indicate the convergance result
            print (name, "No")
    
    elif len(x) < 6:
        P1 = "NA"
        P2 = "NA"
        P3 = "NA"
        P4 = "NA"
        P5 = "NA"
        P6 = "NA"
        AIC = "NA"
        Converge = "F"

        #indicate the convergance result
        print (name, "Fail")
    output = pd.DataFrame({"GroupID": [name], "B0": [P1], "E": [P2], "Eh": [P3], "El": [P4], "Th": [P5], "Tl": [P6], "AIC": [AIC], "Converge": [Converge]})
    schoolfieldDF = schoolfieldDF.append(output)

schoolfieldDF.head(n=10)
#save the cubic DF to csv
schoolfieldDF.to_csv('../Result/schoolfield_model1.csv')

#################Fitting the Schoolfield model (simplified 1)
#define the residual function
def residual4(params, x, data):
    """ calculate residual for Schoolfield model simplified 1"""
    #get the value of the params from a dict
    parvals = params.valuesdict()
    B0 = parvals['B0']
    E = parvals['E']
    Eh = parvals['Eh']
    Th = parvals['Th']
    model = np.log((B0*np.exp((-E/k)*((1/x)-(1/283.15)))) / (1+(np.exp((Eh/k)*((1/Th)-(1/x))))))
    return data - model

#creat DF to store schoolfield model fitting
schoolfieldDF2 = pd.DataFrame()

#start the model fitting
#group the DF by GroupID, using groupby function in pandas

for name, group in DF.groupby('GroupID'):

    #get x and y value
    x = group.KTemp
    y = group.LogTraitValue

    #give initial parameter
    #.iloc to get the nth of the list
    params = Parameters()
    params.add('B0', value= group.B0.iloc[0])
    params.add('E', value= abs(group.E.iloc[0]))
    params.add('Eh', value= abs(group.Eh.iloc[0]))
    params.add('Th', value= group.Th.iloc[0])

    try:
        result = minimize(residual4, params, args=(x, y))
        #assign all variables to make a dataframe
        P1 = result.params['B0'].value
        P2 = result.params['E'].value
        P3 = result.params['Eh'].value
        P4 = result.params['Th'].value

        Converge = "Y"
        
        #get the un-logged version of AIC
        model = np.log((P1*np.exp((-P2/k)*((1/x)-(1/283.15)))) / (1 + (np.exp((P3/k)*((1/P4)-(1/x))))))
        yhat = np.exp(y) - np.exp(model)
        SSR = np.sum(((yhat)**2))
        AIC = (2*4 + len(x)*np.log(SSR/len(x)))

        #indicate the convergance result
        print (name, "Yes")

    except ValueError:
        #when encounter value error means convergance failed
        #put NA to the results for models that don't converge
        P1 = "NA"
        P2 = "NA"
        P3 = "NA"
        P4 = "NA"
        AIC = "NA"
        Converge = "N"
        
        #indicate the convergance result
        print (name, "No")

    output = pd.DataFrame({"GroupID": [name], "B0": [P1], "E": [P2], "Eh": [P3], "Th": [P4], "AIC": [AIC], "Converge": [Converge]})
    schoolfieldDF2 = schoolfieldDF2.append(output)
#save
schoolfieldDF2.to_csv('../Result/schoolfield_model2.csv')

#################Fitting the Schoolfield model (simplified 2)
#define the residual function
def residual5(params, x, data):
    """ calculate residual for Schoolfield model simplified 2"""
    #get the value of the params from a dict
    parvals = params.valuesdict()
    B0 = parvals['B0']
    E = parvals['E']
    El = parvals['El']
    Tl = parvals['Tl']
    model = np.log((B0*np.exp((-E/k)*((1/x)-(1/283.15)))) / (1+(np.exp((El/k)*((1/Tl)-(1/x))))))
    return data - model

#creat DF to store schoolfield model fitting
schoolfieldDF3 = pd.DataFrame()

#start the model fitting
#group the DF by GroupID, using groupby function in pandas

for name, group in DF.groupby('GroupID'):

    #get x and y value
    x = group.KTemp
    y = group.LogTraitValue

    #give initial parameter
    #.iloc to get the nth of the list
    params = Parameters()
    params.add('B0', value= group.B0.iloc[0])
    params.add('E', value= abs(group.E.iloc[0]))
    params.add('El', value= abs(group.El.iloc[0]))
    params.add('Tl', value= group.Tl.iloc[0])

    try:
        result = minimize(residual5, params, args=(x, y))
        #assign all variables to make a dataframe
        P1 = result.params['B0'].value
        P2 = result.params['E'].value
        P3 = result.params['El'].value
        P4 = result.params['Tl'].value

        Converge = "Y"
        
        #get the un-logged version of AIC
        model = np.log((P1*np.exp((-P2/k)*((1/x)-(1/283.15)))) / (1 + (np.exp((P3/k)*((1/P4)-(1/x))))))
        yhat = np.exp(y) - np.exp(model)
        SSR = np.sum(((yhat)**2))
        AIC = (2*4 + len(x)*np.log(SSR/len(x)))

        #indicate the convergance result
        print (name, "Yes")

    except ValueError:
        #when encounter value error means convergance failed
        #put NA to the results for models that don't converge
        P1 = "NA"
        P2 = "NA"
        P3 = "NA"
        P4 = "NA"
        AIC = "NA"
        Converge = "N"
        
        #indicate the convergance result
        print (name, "No")

    output = pd.DataFrame({"GroupID": [name], "B0": [P1], "E": [P2], "El": [P3], "Tl": [P4], "AIC": [AIC], "Converge": [Converge]})
    schoolfieldDF3 = schoolfieldDF3.append(output)
#save
schoolfieldDF3.to_csv('../Result/schoolfield_model3.csv')


    
