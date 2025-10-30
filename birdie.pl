open(INFILE, "seasonstats.txt") or die "seasonstats.txt: $!";

%players = ();

while ($line = <INFILE>)
{
   chop($line);
   @temparr = ();
   @temparr = split(/[ \t]+/, $line);
   $birdie = ($temparr[19] + $temparr[16] + $temparr[14] + $temparr[13] + $temparr[12] - ($temparr[6] - $temparr[5]) - ($temparr[10] - $temparr[9]) - $temparr[17] - $temparr[15]) / $temparr[3];

   push(@{$players{$birdie}}, $temparr[0]);
   sort @{$players{$birdie}};
#   print "@{$players{$birdie}}\n";
}

foreach $key (reverse (sort { $a <=> $b} (keys %players)))
{
   @temp = ();
   push(@temp, @{$players{$key}});
   for ($i = 0; $i < @temp; $i++)
   {
      printf("%-20s\t%.3f\n", $temp[$i], $key);
   }
}

