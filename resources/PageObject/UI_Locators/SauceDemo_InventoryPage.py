# Inventory (products) page: https://www.saucedemo.com/inventory.html
INVENTORY_TITLE_LABEL = 'css:[data-test="title"]'
INVENTORY_ITEM = 'css:[data-test="inventory-item"]'
INVENTORY_ITEM_NAME = 'css:[data-test="inventory-item-name"]'
INVENTORY_ITEM_PRICE = 'css:[data-test="inventory-item-price"]'
INVENTORY_SORT_SELECT = 'css:[data-test="product-sort-container"]'
INVENTORY_ACTIVE_SORT_OPTION = 'css:[data-test="active-option"]'

# Add/Remove button of the product card whose name is {name}; fill in with Format String.
INVENTORY_ITEM_BUTTON_BY_NAME = (
    "xpath://div[@data-test='inventory-item']"
    "[.//div[@data-test='inventory-item-name'][normalize-space()='{name}']]//button"
)
