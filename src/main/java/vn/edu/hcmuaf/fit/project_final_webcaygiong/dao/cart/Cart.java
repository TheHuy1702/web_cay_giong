package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class Cart implements Serializable {
    Map<Integer, CartProduct> data;

    public Cart() {
        data = new HashMap<>();
    }

    public Map<Integer, CartProduct> getData() {
        return data;
    }

    public boolean add(Product p, int quantity) {
        if (data.containsKey(p.getProductID())) {
            return update(p.getProductID(), data.get(p.getProductID()).getQuantity() + quantity);
        }
        data.put(p.getProductID(), convert(p, quantity));
        return true;
    }

    // tính tổng số luong cua mot san pham.
    public int getQuantityOfProduct(int productID) {
        if (data.containsKey(productID)) {
            return data.get(productID).getQuantity();
        }
        return 0;
    }

    public boolean update(int productID, int quantity) {
        if (!data.containsKey(productID) || quantity < 1) return false;
        CartProduct cartProduct = data.get(productID);
        cartProduct.setQuantity(quantity);
        data.put(productID, cartProduct);
        return true;
    }

    public boolean removeProduct(int pid) {
        if (!data.containsKey(pid)) return false;
        data.remove(pid);
        return true;
    }

    public List<CartProduct> getList() {
        return new ArrayList<>(data.values());
    }

    // tính tổng số lượng sản pham;
    public int getTotalQuantity() {
        AtomicInteger total = new AtomicInteger(0);
        data.values().stream().forEach(CartProduct -> total.addAndGet(CartProduct.getQuantity()));
        return total.get();
    }

    // tính tổng số gia sản pham;
    public Double getTotal() {
        AtomicReference<Double> total = new AtomicReference<>(0.0);
        data.values().stream().forEach(cartProduct -> total.updateAndGet(v -> v + (cartProduct.getQuantity() * cartProduct.getPrice())));
        return total.get();
    }

    private CartProduct convert(Product p, int quantity) {
        CartProduct re = new CartProduct();
        re.setProductID(p.getProductID());
        re.setName(p.getName());
        re.setImageMain(p.getImageMain());
        re.setPrice(p.getPrice());
        re.setStock(p.getStock());
        re.setCategoryID(p.getCategoryID());
        re.setIntroduce(p.getIntroduce());
        re.setInfoPro(p.getInfoPro());
        re.setQuantity(quantity);
        return re;
    }

    public static void main(String[] args) {
        Cart cart = new Cart();
        Product product = new Product(1, "Hoa lan", 20, "image", 100, 2, "gioi thieu", "thong tin san pham");
        Product product1 = new Product(2, "Hoa hue", 20, "image", 100, 2, "gioi thieu", "thong tin san pham");
        Product product2 = new Product(3, "Hoa cuc", 20, "image", 100, 2, "gioi thieu", "thong tin san pham");

        System.out.println(cart.add(product, 2));
        System.out.println(cart.add(product, 5));
        System.out.println(cart.add(product, 6));
        System.out.println(cart.add(product, 5));
        System.out.println(cart.add(product, 7));

        Map<Integer, CartProduct> d = cart.getData();
        System.out.println(d);
    }
}
