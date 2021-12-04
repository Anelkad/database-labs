import random
f1=open("woman.txt", "r")
f2=open("man.txt", "r")
f3=open("surname.txt", "r")
f4=open("city.txt", "r")
f=open("result.txt","w")
#fd=open("dealers.txt","w")
#fc=open("clients.txt","w")
namewoman=f1.read().split('\n')
nameman=f2.read().split('\n')
surname=f3.read().split('\n')
city=f4.read().split('\n')
did=1
for i in range(50):
    a1=random.randint(0,9)
    a2=random.randint(0,9)
    a3=random.randint(0,9)
    a4=random.randint(0,9)
    a5=random.randint(0,9)
    a6=random.randint(0,9)
    a7=random.randint(0,9)
    a8=random.randint(0,9)
    salary=random.randint(200,1000)*1000
    name=nameman[random.randint(0,len(nameman)-1)]
    sname=surname[random.randint(0,len(surname)-1)]
    c=city[random.randint(0,len(city)-1)]
    f.write("insert into persons values(\'D%d\',\'%s\',\'%s\',\'male\',\'%s\',\'+7(7%d7)%d%d%d%d%d%d%d\');\n" 
        %(did,name,sname,c,a1,a2,a3,a4,a5,a6,a7,a8))
    fd.write("\'D%d\',\'%s\',\'%s\',\'male\',\'%s\',\'+7(7%d7)%d%d%d%d%d%d%d\',%d\n" 
        %(did,name,sname,c,a1,a2,a3,a4,a5,a6,a7,a8,salary))
    did+=1
id=1
for i in range(300):
    a1=random.randint(0,9)
    a2=random.randint(0,9)
    a3=random.randint(0,9)
    a4=random.randint(0,9)
    a5=random.randint(0,9)
    a6=random.randint(0,9)
    a7=random.randint(0,9)
    a8=random.randint(0,9)
    salary=random.randint(200,1000)*1000*12
    name=namewoman[random.randint(0,len(namewoman)-1)]
    sname=surname[random.randint(0,len(surname)-1)]
    c=city[random.randint(0,len(city)-1)]
    f.write("insert into persons values(\'C%d\',\'%s\',\'%sa\',\'female\',\'%s\',\'+7(7%d7)%d%d%d%d%d%d%d\');\n" 
        %(id,name,sname,c,a1,a2,a3,a4,a5,a6,a7,a8))
    fc.write("\'C%d\',\'%s\',\'%sa\',\'female\',\'%s\',\'+7(7%d7)%d%d%d%d%d%d%d\',%d\n" 
        %(id,name,sname,c,a1,a2,a3,a4,a5,a6,a7,a8,salary))
    id+=1
for i in range(300):
    a1=random.randint(0,9)
    a2=random.randint(0,9)
    a3=random.randint(0,9)
    a4=random.randint(0,9)
    a5=random.randint(0,9)
    a6=random.randint(0,9)
    a7=random.randint(0,9)
    a8=random.randint(0,9)
    salary=random.randint(200,1000)*1000*12
    name=nameman[random.randint(0,len(nameman)-1)]
    sname=surname[random.randint(0,len(surname)-1)]
    c=city[random.randint(0,len(city)-1)]
    f.write("insert into persons values(\'C%d\',\'%s\',\'%s\',\'male\',\'%s\',\'+7(7%d7)%d%d%d%d%d%d%d\');\n" 
        %(id,name,sname,c,a1,a2,a3,a4,a5,a6,a7,a8))
    fc.write("\'C%d\',\'%s\',\'%s\',\'male\',\'%s\',\'+7(7%d7)%d%d%d%d%d%d%d\',%d\n" 
        %(id,name,sname,c,a1,a2,a3,a4,a5,a6,a7,a8,salary))
    id+=1
f.close()
fd.close()
fc.close()