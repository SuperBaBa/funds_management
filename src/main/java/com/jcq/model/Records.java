package com.jcq.model;

public class Records {
    private String id;

    private Double transactionFunds;

    private String transactionDate;

    private String transactionTypeId;

    private String userId;

    private String tradingObject;
    
    private TransactionType dealType;
    
    private User user;
    
    

    public TransactionType getDealType() {
		return dealType;
	}

	public void setDealType(TransactionType dealType) {
		this.dealType = dealType;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Double getTransactionFunds() {
        return transactionFunds;
    }

    public void setTransactionFunds(Double transactionFunds) {
        this.transactionFunds = transactionFunds;
    }

    public String getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(String transactionDate) {
        this.transactionDate = transactionDate == null ? null : transactionDate.trim();
    }

    public String getTransactionTypeId() {
        return transactionTypeId;
    }

    public void setTransactionTypeId(String transactionTypeId) {
        this.transactionTypeId = transactionTypeId == null ? null : transactionTypeId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getTradingObject() {
        return tradingObject;
    }

    public void setTradingObject(String tradingObject) {
        this.tradingObject = tradingObject == null ? null : tradingObject.trim();
    }
}