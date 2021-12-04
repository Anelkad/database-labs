import random
#f1 = open("bdvehicles.txt", "r")
f2 = open("vehicles.txt", "w")

color_hyu=['\'Silver\'','\'White\'','\'Blue\'','\'Black\'','\'Brown\'']
color_s=['\'Green\'','\'Grey\'','\'Black\'','\'Blue\'','\'Bronze\'']
color_hav=['\'White\'','\'Grey\'','\'Black\'','\'Bronze\'']
color_b=['\'White\'','\'Silver\'','\'Black\'','\'Grey\'']
color_k=['\'Blue\'','\'Black\'','\'Red\'','\'Grey\'','\'White\'']

month=['01','02','03','04','05','06','07','08','09','10','11']
day=['01','02','03','04','05','06','07','08','09','10',
    '11','12','13','14','15','16','17','18','19','20','21','22',
    '23','24','25','26','27','28','29','30']
#INSERT INTO vehicles VALUES (
for line in f1:
    a=line.split(";")
    opt='\''+a[1]+'\''
    if a[7]=='hyundai':
        color=color_hyu
    elif a[7]=='Subaru':
        color=color_s
    elif a[7]=='Haval':
        color=color_hav
    elif a[7]=='BMW':
        color=color_b
    elif a[7]=='Kia Rio':
        color=color_k
    engine='\''+a[3]+'\''
    bodystyle='\''+a[4]+'\''
    trans='\''+a[5]+'\''
    model='\''+a[6]+'\''
    brand='\''+a[7]+'\''
    #year=a[8] #'2012-10-05 00:00:00.000000'
    p=a[9].split('\n')
    price="".join(p)
    for i in range(len(color)):
        for y in [2019,2020,2021]:
            m=month[random.randint(0,10)]
            if m=='02':
                d=day[random.randint(0,27)]
            else:
                d=day[random.randint(0,29)]
            year='\''+str(y)+'-'+m+'-'+d+' 00:00:00.000000'+'\''
            vin='\''+a[0]+str(i+1)+str(y%10)+'\''
            f2.write("insert into vehicles values (%s,%s,%s,%s,%s,%s);\n" %
                (vin,brand,model,opt,color[i],year))
            
        
f2.close()