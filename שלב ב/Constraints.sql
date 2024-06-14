-- Add/modify columns 
alter table PREVENTION_ACTIONS modify action_duration not null;
--Create/Recreate check constraints
alter table PREVENTION_ACTIONS
   add constraint chk_duration
   check (action_duration in ('strong protection for a long time', 'medium protection for a while', 'low protection for a short time'));

-- Add/modify columns 
alter table RESEARCH_STATIONS modify research_subject default 'Nature';

-- Add/modify columns 
alter table RESEARCH_STATIONS modify research_subject not null;

-- Add/modify columns 
alter table EDUCATION_PROGRAMS modify ages default 'all';
