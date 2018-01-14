<?php


namespace AppBundle\Controller;

use AppBundle\Form\ArticleType;
use AppBundle\Form\RegistrationType;
use Doctrine\ORM\QueryBuilder;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Form\Form;
use Symfony\Component\HttpFoundation as Http;
use Symfony\Component\Routing\Annotation\Route;
use AppBundle\Entity as Entity;

class AppController extends Controller
{
    /**
     * @Route("/", name="index")
     */
    public function indexAction() {

        $articles = $this->getArticles([]);
        $users = $this->getDoctrine()->getRepository(Entity\User::class)->findAll();
        $userId = [];

        foreach ($users as $user) {
            if (!in_array($user->getId(), $userId)) {
                $userId[$user->getId()]['author'] = $user->getUsername();
            }
        }

        foreach ($userId as $key=>$value) {
            $articlesCount = $this
                ->getDoctrine()
                ->getRepository(Entity\Article::class)
                ->findBy(['author' => $key]);
            $userId[$key]['articles'] = count($articlesCount);
        }

        return $this->render('default/index.html.twig', [
            'articles' => $articles,
            'usersData' => $userId
        ]);
    }

    /**
     * @Route("/register", name="register")
     */
    public function registerAction(Http\Request $request)
    {
        $form = $this->createForm(RegistrationType::class)->handleRequest($request);

        return $this->render('default/register.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/user/add", name="add")
     * @Method({"POST", "GET"})
     */
    public function addAction(Http\Request $request)
    {
        if (!is_object($this->get('security.token_storage')->getToken()->getUser())) {
            return $this->redirectToRoute('fos_user_security_login');
        }

        $articleForm = $this->createForm(ArticleType::class)->handleRequest($request);

        if ($request->isMethod('POST')) {
            if ($articleForm->isSubmitted()) {
                if ($articleForm->isValid()) {
                    $this->formSubmitter($articleForm);
                }
            }
        }


        return $this->render('default/add.html.twig', [
            'articleForm' => $articleForm->createView(),
        ]);
    }

    /**
     * @param Http\Request $request
     * @param string $entity
     * @param int $id
     * @return Http\Response
     * @Route("/user/edit/{entity}/{id}", name="edit")
     * @Method({"POST", "GET"})
     */
    public function editAction(Http\Request $request, string $entity, int $id)
    {
        $className = $this->getClassName($entity);
        $object = $this->getDoctrine()->getRepository($className)->findOneById($id);
        $form = $this
            ->entityFormBuilder($entity, $object)
            ->handleRequest($request);

        if ($request->isMethod('post')) {
            if ($form->isSubmitted()) {
                if ($form->isValid()) {
                    $this->formSubmitter($form);
                }
            }
        }

        return $this->render(':default:edit.html.twig', [
            'form' => $form->createView()
        ]);
    }

    /**
     * @Route("/delete", name="delete")
     */
    public function deleteAction(Http\Request $request) {

        $em = $this->getDoctrine()->getManager();

        $className = $this->getClassName($request->request->get('entity'));

        $object = $em->getRepository($className)->findOneById($request->request->get('id'));

        try {
            $em->remove($object);
            $em->flush();
            $response = Http\JsonResponse::create('kek');
        } catch (\Exception $exception) {
            $response = Http\JsonResponse::create('error', 500);
        }

        return $response;
    }

    /**
     * @param string $entity
     * @return string
     */
    protected function getClassName(string $entity)
    {

        $className = ucfirst($entity);

        $class = 'AppBundle\\Entity\\' . $className;

        return $class;
    }

    /**
     * @param $entity
     * @param $object
     * @return Form
     */
    protected function entityFormBuilder($entity, $object)
    {

        $formName = 'AppBundle\Form\\' . ucfirst($entity) . 'Type';

        $form = $this->createForm($formName, $object);

        return $form;

    }

     /**
     * @param array $criteria
     * @param array|null $orderBy
     * @param int|null $limit
     * @param int|null $offset
     * @return Entity\Article[]|array
     */
    private function getArticles(array $criteria, array $orderBy = null, int $limit = null, int $offset = null) {
        $articles = $this
            ->getDoctrine()
            ->getRepository(Entity\Article::class)
            ->findBy($criteria, $orderBy, $limit, $offset);

        return $articles;
    }

    /**
     * @param Form $form
     */
    private function formSubmitter(Form $form) {
        $formData = $form->getData();
        $em = $this->getDoctrine()->getManager();

        //Set author to object if it is an Article
        if ($formData instanceof Entity\Article) {
            $formData->setAuthor($this->getUser());
        }

        //Check if requested data is in DB or not
        if (!$formData->getId())
        {
            $em->persist($formData);
        }

        try {
            $em->flush();
            $this->addFlash('success', 'Dane zostały poprawnie zapisane');
        } catch (\Exception $exception) {
            $this->addFlash('error', $exception->getMessage());
        }

    }
}