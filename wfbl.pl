open(INFILE, "seasonstats.txt") or die "seasonstats.txt: $!";

%players = ();

while ($line = <INFILE>)
{
   chop($line);
   @temparr = ();
   @temparr = split(/[ \t]+/, $line);
   $birdie = ($temparr[7] + $temparr[12] + $temparr[13] + $temparr[14] - $temparr[15] + $temparr[16] + $temparr[19]) / $temparr[3];

   push(@{$players{$birdie}}, $temparr[0]);
   sort @{$players{$birdie}};
#   print "@{$players{$birdie}}\n";
}

$j = 1;
foreach $key (reverse (sort { $a <=> $b} (keys %players)))
{
   @temp = ();
   push(@temp, @{$players{$key}});
   for ($i = 0; $i < @temp; $i++, $j++)
   {
      printf("%d\t%-20s\t%.3f\n", $j, $temp[$i], $key);
   }
}

