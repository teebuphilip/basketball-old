@totalplayers = ();
@categories = ("Assists", "Blocks", "FGM", "FGA", "FTM", "FTA", "Points", "Steals", "Rebounds");
@totals = (0, 0, 0, 0, 0, 0, 0, 0, 0);



if ($ARGV[0] ne "")
{
   $searchforplayer = $player = $ARGV[0];
   $line = `cat out.* | grep "$player"`; 

   @newlines = split(/\n/, $line);
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
         $gamesplayed = $string[$lastentr];
         $totals[$k++] += ($avg * 4);
      }
   }

   print "Stats for $player are:\n"; 
   print "Games Played is $gamesplayed.\n";


   for ($i = 0; $i < @totals; $i++)
   {
      if (($i == 2) || ($i == 4))
      {
         printf "%s percentage is %.3f.\n", $categories[$i], ($totals[$i] / $totals[$i + 1]);
         $i++;
      }

      else
      {
         printf "%s is %.3f.\n", $categories[$i], ($totals[$i] / 4);
      }
   }
}


else
{
   die("PGM ends with no input.\n");
}

if (open(INFILE, "out.PTS") == 0)
{
   die("unable to open out.PTS");
}

print "\n\n\n";

@likeplayers = ();

while ($line = <INFILE>)
{
   chop($line);
   @arr = split(/[ \t]+/, $line);
   $lastentr = @arr - 1;
   $avg = $arr[$lastentr - 2] / $arr[$lastentr];

#   $avg = ($arr[0] / $arr[2]);
   if ($avg >= (($totals[6] / 4) - 1.0))
   {
      push(@likeplayers, $arr[1]);
   }
}

# print "Here are the list of players like $searchforplayer in scoring:\n";
# print "@likeplayers\n";

close(INFILE);

for ($i = 0; $i < @likeplayers; $i++)
{
   $line = `cat out.AS out.TR | grep "$likeplayers[$i]"`;

   @newlines = split(/\n/, $line);

   $badplayer = 0;

   for ($k = $j = 0; $j < @newlines; $j++)
   {
      @string = split(/[ \t]+/, $newlines[$j]);
      $lastentr = @string - 1;
      $avg = $string[$lastentr - 2] / $string[$lastentr];

#      $avg = $string[0] / $string[2];
      if ($avg < (($totals[$k] / 4) -1.0))
      {
         $badplayer = 1;
         next;
      }

      else
      {
         $k = 8;
      }
   }

   if ($badplayer == 0)
   {
      push(@verylikeplayer, $likeplayers[$i]);
   }
}

print "Here is the list of players with stats equal to or better than $searchforplayer\n";
for ($i = 0; $i < @verylikeplayer; $i++)
{
   print "$verylikeplayer[$i]\n";
}
