class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  
  def initialize(sender, receiver, amount)
    self.sender = sender
    self.receiver = receiver
    self.amount = amount
    self.status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid? && self.sender.balance >= self.amount
  end

  def execute_transaction
    if self.status == "pending" && self.valid?
      self.sender.withdraw(self.amount)
      self.receiver.deposit(self.amount)
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      self.sender.deposit(self.amount)
      self.receiver.withdraw(self.amount)
      self.status = "reversed"
    end
  end
end
