REPORT Z_PARAMETERS.

"parameters are used to take input from user
parameters username(20) type c lower case default 'username' obligatory.

parameters mytime type t.
mytime = sy-uzeit.

parameters mydate type d.
mydate = sy-datum.

parameters a type i .   
parameters b type i .

data ans type i.
ans = a + b.

write:/ 'ans to input is: ',ans,
        / mytime,
        / mydate,
        / username.
