class Transfer
  
  attr_accessor :sender, :receiver, :status
  attr_reader :amount
  
  def initialize(sender, receiver, amount)
    @sender = sender 
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end 
 

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction

    if valid? && self.status == "pending" && sender.balance > amount
        sender.balance -= amount
        receiver.balance += amount
        self.status = "complete"

    else
      self.status = "rejected"
       "Transaction rejected. Please check your account balance."
    end
     #sender wants to transfer an amount (goes into pending status)
     #need to verify that sender has enough to cover that transfer
    # if sender has valid account, transfer amount to balance. Subtact that amount from sender and add to receiver.
    #make sure this happens only once 
    #if sender has no money, reject that tranfer 
    #make sure a transfer can be reversed and status becomes reversed. 
     #
  end
  
  def reverse_transfer
    
    if self.status == "complete"
        sender.balance += amount
        receiver.balance -= amount
        self.status = "reversed"
    end
  end
end
