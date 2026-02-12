
class Animals{
    String color;
    String name;
    int weight;
}
class Bird extends Animals{
    int altitude;
    
}
class Aquatic extends Animals{
    int fins;
}
class Fish extends Aquatic{
    int gills;
    int scales;

}
public class Inheritance{
    public static void main(String[] args){
        Bird b1=new Bird();
        b1.color="white";
        b1.name="dove";
        b1.altitude=300;

        Fish f1=new Fish();
        f1.name="clown fish";
        System.out.println(f1.name);
    }
}