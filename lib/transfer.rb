require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    #binding.pry
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    if self.sender.valid? && self.receiver.valid? && self.sender.balance > self.amount
      return true
    else
      return false
    end
  end

  def execute_transaction
    if self.status == "pending" && self.valid?
      if self.sender.withdrawl(self.amount) && self.receiver.deposit(self.amount)
        self.status = "complete"
      end
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete" && self.valid?
      if self.sender.deposit(self.amount) && self.receiver.withdrawl(self.amount)
        self.status = "reversed"
      end
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
end
