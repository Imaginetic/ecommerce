class Coupon < ApplicationRecord
    belongs_to :user, optional: true
    # kind massive o target
    # code
    # amount value (percent or fixed-amount)
    # discount kind (percent or fixed)
    # user only for target Coupon
    # count how many times are used

    def self.usable?
        valid_on_count?
    end

    def valid_on_count?
        kind.eq?('target') ? count > 0 : true
    end

    def compute_total(total)
        if discount.eq?('percent')
            percent_value = amount.to_f / 100
            total = total - (total * percent_value)
        else
            total -= amount
            (total < 0) ? 0 : total
        end
    end
end

# controller antes de pagar
coupon = Coupon.find_by(code: get_code_from_params)
if.coupon.valid? 
    price=coupon.compute_total(order.total)
end

# controller despues de pagar
coupon.count += 1
coupon.save!