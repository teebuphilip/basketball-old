# $line[1] = `cat out.* | grep "duncan,t"`;
# $line[1] = `cat out.* | grep "ratliff,t"`;
# $line[1] = `cat out.* | grep "rahim,s"`;

@totalplayers = ();
# @players = ("duncan", "rahim", "ratliff", "williamson", "christie", "starks");
@categories = ("Assists", "Blocks", "FGM", "FGA", "FTM", "FTA", "Points", "Steals", "Rebounds");
@totals = (0, 0, 0, 0, 0, 0, 0, 0, 0);
@weekly = (130, 35, 47, 100, 75, 100, 610, 46, 260);


if ($ARGV[0] ne "")
{
   @newplayers = split(/:/, $ARGV[0]);
}

else
{
   @newplayers = ();
}

push(@players, @newplayers);

if (@players > 12)
{
   print "Too many players\n";
   exit(1);
}

for ($i = 0; $i < @players; $i++)
{
   push(@totalplayers,$players[$i]);
   $line = `cat out.* | grep "$players[$i]"`; 

   @newlines = split(/\n/, $line);

   if (@newlines != 8)
   {
      print "Check out $players[$i]\n";
      exit(1);
   }

   for ($k = $j = 0; $j < @newlines; $j++)
   {
      if (($j == 2) || ($j == 3))
      {
        @string1 = split(/\-\-/, $newlines[$j]);
        @string = split(/of/, $string1[1]);
        $totals[$k++] += $string[0];
        $totals[$k++] += $string[1];
      }

      elsif ($j == 6)
      {
      }

      else
      {
         @string = split(/[ \t]+/, $newlines[$j]);
         $lastentr = @string - 1;
         $avg = $string[$lastentr - 2] / $string[$lastentr];
         $totals[$k++] += ($avg * 3.33);
      }
   }
}


print "Here are the cum weekly numbs with the following players\n";
for ($i = 0; $i < @totalplayers; $i++)
{
   print "$totalplayers[$i]\n";
}

print "\n\n";

for ($i = 0; $i < @weekly; $i++)
{
   if (($i == 2) || ($i == 4))
   {
      @newarr = ($totals[$i], $totals[$i + 1]);
      @temparr = ($weekly[$i], $weekly[$i + 1]);
      printf "%s Total So Far: %.4f,%d for %d\tNeed to hit %.4f\n",
             $categories[$i], ($newarr[0] / $newarr[1]), $newarr[0],
             $newarr[1], ($temparr[0] / $temparr[1]);
      $i++;
   }

   else
   {
      if ((12 - @totalplayers) != 0)
      { 
         printf "%s Total So Far: %.1f\tNeed to get: %.1f\tPer guy per game: %.1f\n",
          $categories[$i], $totals[$i], $weekly[$i] - $totals[$i],
          (($weekly[$i] - $totals[$i]) / ((12 - @totalplayers) * 3.33));
      }

      else
      {
         printf "%s Total So Far: %.1f\tNeed to get: %.1f\n",
           $categories[$i], $totals[$i], $weekly[$i] - $totals[$i];
      }
   }
}


if (@totalplayers < 12)
{
   printf "\n\nGet %d more players.\n", 12 - @totalplayers;
}

exit(0);
