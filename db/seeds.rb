
entry_points = %w[A B C]
slot_sizes = [0, 1, 2] # 0 - small, 1 - medium, 2 - large
rates = [20, 60, 10] # 20 - small, 60 - medium, 100 - large

entry_points.each do |point|
  entry_point = EntryPoint.create(name: point)
  if entry_point&.id
    slot_sizes.each do |slot|
      (1..10).step(1) do |n|
        Slot.create(
          entry_point: entry_point,
          name: "#{point}_#{n}#{slot}",
          status: "green",
          rate: rates[slot].to_i
        )
      end
    end
  end
end