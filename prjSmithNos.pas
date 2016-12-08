program prjSmithNos;

{$mode objfpc}{$H+}

uses
  sysUtils, strUtils;

function GetPrimeFactors(n: integer): string;
var
  i: integer;
  list: string;
begin
  list:= '';
  while n mod 2 = 0 do
    begin
      list:= list + '2*';
      n:= n div 2;
    end;
  i:= 3;
  while i<= round(sqrt(n))+1 do
    begin
      while n mod i = 0 do
        begin
          list:= list + concat(inttostr(i),'*');
          n:= n div i;
        end;
      inc(i,2);
    end;
  if n>2 then
    list:= list + concat(inttostr(n));
  if list[length(list)]='*' then
    list:= leftstr(list,length(list)-1);
  GetPrimeFactors:= list;

end;

function CheckSmith(num: integer; primeFactors: string): boolean;
var
  i, total_A, total_B: integer;
  numStr: string;
begin
  total_A:= 0;
  total_B:= 0;
  numStr:= inttostr(num);
  for i:= 1 to length(primeFactors) do
    if primeFactors[i] in ['0'..'9'] then
      total_A:= total_A + strtoint(primeFactors[i]);
  for i:= 1 to length(numStr) do
    if numStr[i] in ['0'..'9'] then
      total_B:= total_B + strtoint(numStr[i]);
  if (total_A = total_B) and AnsiContainsStr(primeFactors,'*') then
    CheckSmith:= true
  else
    CheckSmith:= false;
end;

var
  num, startPoint, endPoint: integer;
begin
  write('Starting point: ');
  readln(startPoint);
  write('Ending point: ');
  readln(endPoint);
  if startPoint > 2 then
    num:= startPoint
  else
    num:= 2;
  if startPoint < endPoint then
    repeat
      inc(num);
      if CheckSmith(num, GetPrimeFactors(num)) then
        writeln(num);
    until  (num = endPoint);
  writeln('Completed.');
  readln;
end.

