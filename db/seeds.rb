
entry_points = %w[A B C]
slot_sizes = [0, 1, 2] # 0 - small, 1 - medium, 2 - large
rates = [20, 60, 100] # 20 - small, 60 - medium, 100 - large

entry_points.each do |point|
  entry_point = EntryPoint.create(name: point)
  if entry_point&.id
    slot_sizes.each do |slot|
      (1..10).step(1) do |n|
        slot_number = n.to_s.size == 1 ? "0#{n}" : n
        Slot.create(
          entry_point: entry_point,
          name: "#{point}-#{slot}-#{slot_number}",
          status: "green",
          rate: rates[slot].to_i
        )
      end
    end
  end
end