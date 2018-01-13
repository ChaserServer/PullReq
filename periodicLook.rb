def _periodicLook ()

	if  ($turn % 2 == 0) && (direction == 0)
		$look = 0
		$tar = 1
	elsif ($turn % 2 == 0) && (direction == 3)
		$look = 3
		$tar = 1
	elsif ($turn % 2 == 0) && (direction == 6)
		$look = 6
		$tar = 1
	elsif ($turn % 2 == 0) && (direction == 9)
		$look = 9
		$tar = 1
	end

end