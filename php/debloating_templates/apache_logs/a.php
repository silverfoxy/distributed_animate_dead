<?php

Interface A {
    public function func_A();
}

Interface B extends A {
    public function func_B();
}

class C implements A {
    public function func_A() {
        echo 'Func A called'.PHP_EOL;
    }
}

class D implements B {
    public function func_A() {
        echo 'Func A called'.PHP_EOL;
    }
    public function func_B() {
        echo 'Func B called'.PHP_EOL;
    }
}

class E {
    public function __construct(B $b) {
        echo 'type of B is'.get_class($b).PHP_EOL;
    }
}

$e = new E(new C);