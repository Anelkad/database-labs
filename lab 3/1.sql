--1
select title from course where credits>3;
select room_number from classroom where building in ('Watson','Packard');
select title from course where dept_name='Comp. Sci.';
select course.title from section,course where section.semester = 'Fall' and section.course_id=course.course_id;
select name from student where tot_cred between 45+1 and 90+1;
select name from student where substring(name,length(name),1) in ('a','e','i','o','u');
select course.title from course,prereq where prereq.prereq_id = 'CS-101' and course.course_id = prereq.course_id;
--2
select dept_name, avg(salary) as avg_salary from instructor group by dept_name order by avg_salary;

select building, count(course_id) from section group by building order by count(course_id) desc limit 1;

select dept_name from (select dept_name, count(course_id) as courses
    from course group by dept_name order by courses) as given where courses
     in (select min(courses) from
         (select dept_name, count(course_id) as courses
            from course group by dept_name order by courses) as given);

select s.id, s.name,count(c.course_id) as number from takes as t,student as s,course as c
    where t.id=s.id and c.course_id=t.course_id and
          c.dept_name='Comp. Sci.' group by s.id having count(c.course_id)>3;

--select name from instructor where dept_name in ('Biology', 'Philosophy', 'Music');
select distinct i.name from instructor as i, teaches as t, course as c
    where i.id=t.id and c.course_id = t.course_id
      and c.dept_name in ('Biology', 'Philosophy', 'Music');

select distinct i.name
from teaches as t,instructor as i
where t.year= 2018 and t.id=i.id and
 i.name not in (select i.name
 from teaches as t,instructor as i
 where t.year= 2017 and t.id=i.id);
--3
select distinct s.name from student as s,takes as t,course as c
where s.id=t.id and t.course_id=c.course_id and c.dept_name = 'Comp. Sci.' and t.grade in ('A','A-')
    order by s.name;

select distinct i.name from
        (select id, count(grade) from takes where grade in ('B-','C','C+','C-','F','D')
            group by id) as t,
                instructor as i,advisor as a
where a.s_ID=t.id and a.i_id=i.id;

select distinct s.dept_name from student as s,
(select distinct id from takes except select id from takes where grade in ('F','C')
group by id having count(grade)>0)as t
where s.id=t.id;

select name from instructor where id in
(select distinct id from teaches except select teaches.id
from takes,teaches
where takes.course_id=teaches.course_id and takes.sec_id=teaches.sec_id and
      takes.semester=teaches.semester and takes.year=teaches.year and
      takes.grade = 'A'
group by teaches.id having count(grade)>0);

select distinct c.title from course as c,section as s, time_slot as t
where c.course_id=s.course_id and s.time_slot_id=t.time_slot_id and
      t.end_hr<13;