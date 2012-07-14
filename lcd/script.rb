while 1 do
  for i in 0..10 do
    system("echo 'DC 80 21 #{i} 10' > pipe")
    sleep 0.5
  end
end
