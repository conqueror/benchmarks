<?php

use Phalcon\Mvc\Controller;

class IndexController extends Controller
{
    public function indexAction()
    {
        return "Hello";
    }

    public function userAction()
    {
        $params = $this->dispatcher->getParams();
        return "Hello User " . $params[0];
    }
}