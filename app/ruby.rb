# def consulta(cubic_m)
#   @a = Price.where("weight_min < ? AND weight_max > ?", cubic_m, cubic_m)
#   @b = []
#   @a.each do |single|
#     @b << [single.transport_company.trading_name, "PESO MÍNIMO: #{single.weight_min.to_s}, PESO MÁXIMO: #{single.weight_max.to_s}"]
#   end

#   return [@b, @a]
# end


# Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:150, weight_max:600, value_per_km:3.25, transport_company:TransportCompany.last)


# WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", delivery_time: 4, cubic_size: 0.3, total_weight: 1.2, transport_company_id: 1, total_distance: 3)

# price = Price.where(transport_company: ordem.transport_company_id).where("cubic_meters_min <= ? AND cubic_meters_max >= ? AND weight_min <= ? AND weight_max >= ?", ordem.cubic_size, ordem.cubic_size, ordem.total_weight, ordem.total_weight)

# #do úsuario => receiver_address, sender_address, receiver_name, receiver_cpft, total_distance
# #do produto => cubic_size, total_weight
# #da transportadora => , delivery_time, , total_price
