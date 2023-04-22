#=

Counting Sundays

Problem 19

You are given the following information, but you may prefer to do some research for yourself.

    1 Jan 1900 was a Monday.
    Thirty days has September,
    April, June and November.
    All the rest have thirty-one,
    Saving February alone,
    Which has twenty-eight, rain or shine.
    And on leap years, twenty-nine.
    A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
=#

# APPROACH: modular arithmetic can simplify this problem a lot



function isleapyear(year)
 if (year % 4 == 0) &  ( (year % 100 != 0) | (year % 400 == 0) )
  return true
 else
  return false
 end
end

function monlen(mon, year)
 if mon == 2
  if isleapyear(year)
   return 29
  else
   return 28
  end
 else
 monlens = [31,28,31,30, 31,30,31,31,30,31,30,31]
 return monlens[mon]
 end
end



dates = []

# start on the first sunday "known"--- 7 Jan 1900, and count up from there (once 1 jan 1901 is reached)

year = 1900
mon_m1 = 0      # month of the year...        MINUS 1: mon_m1 =0 is january
day_m1 = 6      # day of the month (a sunday) MINUS 1: day_m1 =0 is the first of the month


#loop through dates and count the sundays
sundays = 0

while year != 2001
 # increment day
 newday_m1 = day_m1 + 7

 #check if new month or year is reached
 if newday_m1 >= monlen(mon_m1 +1, year)
  newmon_m1 = mon_m1+1
  if newmon_m1 == 12
   newyear = year+1
  else
   newyear = year
  end
 else
  newmon_m1 = mon_m1
  newyear = year
 end
 
 #increment day, rotate if a month boundary is reached
 
 global day_m1 = newday_m1 % monlen(mon_m1+1, year)
 global mon_m1 = newmon_m1 % 12 
 global year = newyear

 day = day_m1 + 1
 mon = mon_m1 + 1

 date = "$day.$mon.$year"
 print(date, '\n')
 push!(dates, date)

 #if so, check if new year is reached

 if (year >= 1901) & (year <= 2000) & (day==1)
  global sundays += 1
 end
end

print("there were $sundays sundays on the 1st of the month in the 20th century (as defined in the problem).\n")

