require 'rails_helper'

RSpec.describe BudgetLog, type: :model do
describe "#valid?" do
    context "presence: " do
      it "false when 'transport_company' is nil" do
        budget_log = BudgetLog.new(transport_company: nil)

        budget_log.valid?

        res = budget_log.errors[:transport_company]

        expect(res).to include("é obrigatório(a)")
      end
    end
  end
end
