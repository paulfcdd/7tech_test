<?php

namespace AppBundle\Controller;

use FOS\UserBundle\Controller\SecurityController as BaseController;

/**
 * {@inheritdoc}
 */
class SecurityController extends BaseController {

    /**
     * {@inheritdoc}
     */
    public function renderLogin(array $data) {
        if('user.login' === $this->get('request_stack')->getCurrentRequest()->attributes->get('_route')) {
            $template = 'default\login.html.twig';

        } else {
            $template = 'FOSUserBundle::Security::login.html.twig';
        }

        return $this->container->get('templating')->renderResponse($template, $data);
    }

    public function confirmedAction()
    {
        return $this->render(':default:confirm.html.twig');
    }
}