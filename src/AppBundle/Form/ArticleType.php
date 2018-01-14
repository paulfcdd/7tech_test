<?php


namespace AppBundle\Form;
use AppBundle\Entity\Article;
use AppBundle\Form\Type\CKeditorType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ArticleType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Article::class,
        ]);
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('title', TextType::class, [
                'label' => 'Tytuł artykułu'
            ])
            ->add('content', CKeditorType::class, [
                'label' => 'Zawartość artykułu'
            ])
            ->add('save', SubmitType::class, [
                'label' => 'Zapisz'
            ]);
    }
}